require "openai"

class RagContextService
  VECTOR_DIM = 1536

  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end

  # 🔹 Semantische Suche über beide Typen (abstrakt + konkret)
  def similar_theses(query)
    return [] if query.blank?

    embedding = embed_with_openai(query)
    return [] unless embedding

    abstrakte = AbstrakteAbschlussarbeit
                  .where.not(embedding: nil)
                  .select("abstrakte_abschlussarbeiten.*, (embedding <-> '#{embedding_to_pgvector(embedding)}') AS distance, 'abstrakt' AS typ")
                  .order("distance ASC")
                  .limit(5)

    konkrete = KonkreteAbschlussarbeit
                  .where.not(embedding: nil)
                  .select("konkrete_abschlussarbeiten.*, (embedding <-> '#{embedding_to_pgvector(embedding)}') AS distance, 'konkret' AS typ")
                  .order("distance ASC")
                  .limit(5)

    # 🔸 Ergebnisse zusammenführen und nach Distanz sortieren
    (abstrakte + konkrete).sort_by { |r| r.distance.to_f }.take(5)
  end

  # 🔹 Ausgabeformat für den Chatbot oder Debugging
  def formatted_context(query)
    results = similar_theses(query)
    return "Keine passenden Abschlussarbeiten gefunden." if results.empty?

    results.map do |r|
      if r.respond_to?(:thema)
        <<~TEXT
          [ABSTRAKT]
          Thema: #{r.thema}
          Forschungsprojekt: #{r.forschungsprojekt}
          Betreuer: #{r.betreuer}
          Semester: #{r.semester}
          Distanz: #{r.try(:distance)&.round(3)}
        TEXT
      else
        <<~TEXT
          [KONKRET]
          Matrikelnummer: #{r.matrikelnummer}
          Forschungsprojekt: #{r.forschungsprojekt}
          Betreuer: #{r.betreuer}
          Themenskizze: #{r.angepasste_themenskizze}
          Semester: #{r.semester}
          Distanz: #{r.try(:distance)&.round(3)}
        TEXT
      end
    end.join("\n")
  end

  private

  # 🔹 Erzeugt Embedding über OpenAI API
  def embed_with_openai(text)
    response = @client.embeddings(
      parameters: {
        model: "text-embedding-3-small",
        input: text
      }
    )
    response.dig("data", 0, "embedding")
  rescue => e
    Rails.logger.error "[RAG] OpenAI Embedding Error: #{e.message}"
    nil
  end

  # 🔹 Wandelt Ruby-Array in pgvector-kompatibles Format um
  def embedding_to_pgvector(arr)
    "[" + arr.map { |v| v.round(6) }.join(",") + "]"
  end
end
