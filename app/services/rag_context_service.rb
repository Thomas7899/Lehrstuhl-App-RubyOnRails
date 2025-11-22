require "openai"
require "ostruct"

class RagContextService
  VECTOR_DIM = 1536

  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end
  
  def gather_targeted_context(query:, intent:)
    return "Keine Anfrage gestellt." if query.blank?

    embedding = embed_with_openai(query)
    return "Embedding konnte nicht erstellt werden." unless embedding

    results = []

    case intent
    when "abschlussarbeit"
      results = fetch_similar(AbstrakteAbschlussarbeit, embedding, "abstrakt") +
                fetch_similar(KonkreteAbschlussarbeit, embedding, "konkret")
    when "seminar"
      results = fetch_similar(Seminar, embedding, "seminar") +
                fetch_similar(AbstraktesSeminar, embedding, "abstraktes_seminar")
    when "klausur"
      results = fetch_similar(Klausur, embedding, "klausur") +
                fetch_similar(Klausurergebnis, embedding, "klausurergebnis")
    when "faq"
      # Annahme: Sie haben ein Modell `FaqEntry` mit Spalte `embedding`
      # results = fetch_similar(FaqEntry, embedding, "faq")
      results = [] # Platzhalter für Ihre FAQ-Implementierung
    when "allgemein"
      # Fallback: Suchen Sie in den wichtigsten oder allgemeinsten Modellen
      results = fetch_similar(AbstraktesSeminar, embedding, "abstraktes_seminar") # +
                # fetch_similar(FaqEntry, embedding, "faq") # FAQs hier hinzufügen
    end

    sorted_results = results.uniq.sort_by { |r| r.distance.to_f }.take(10)
    
    formatted_context(sorted_results)
  end

  def fetch_similar(model, embedding, label)
    model
      .where.not(embedding: nil)
      .select("#{model.table_name}.*, (embedding <-> '#{embedding_to_pgvector(embedding)}') AS distance, '#{label}' AS typ")
      .order("distance ASC")
      .limit(5)
  end

  def formatted_context(results)
    return "Keine passenden Datensätze gefunden." if results.empty?

    results.map do |r|
      case r.typ
      when "abstrakt"
        <<~TEXT
          [ABSTRAKTE ABSCHLUSSARBEIT]
          Thema: #{r.thema}
          Forschungsprojekt: #{r.forschungsprojekt}
          Betreuer: #{r.betreuer}
          Semester: #{r.semester}
          Distanz: #{format("%.3f", r.distance)}
        TEXT

      when "konkret"
        <<~TEXT
          [KONKRETE ABSCHLUSSARBEIT]
          Matrikelnummer: #{r.matrikelnummer}
          Forschungsprojekt: #{r.forschungsprojekt}
          Betreuer: #{r.betreuer}
          Themenskizze: #{r.angepasste_themenskizze}
          Semester: #{r.semester}
          Distanz: #{format("%.3f", r.distance)}
        TEXT

      when "seminar"
        <<~TEXT
          [SEMINAR]
          Titel: #{r.titel}
          Semester: #{r.semester}
          Ort: #{r.ort}
          Präsenzdatum: #{r.praesenzdatum}
          Distanz: #{format("%.3f", r.distance)}
        TEXT

      when "abstraktes_seminar"
        <<~TEXT
          [ABSTRAKTES SEMINAR]
          Thema: #{r.thema}
          Beschreibung: #{r.try(:beschreibung) || 'N/A'}
          Distanz: #{format("%.3f", r.distance)}
        TEXT

      when "klausur"
        <<~TEXT
          [KLAUSUR]
          Titel: #{r.titel}
          Modul: #{r.modul}
          Semester: #{r.semester}
          Distanz: #{format("%.3f", r.distance)}
        TEXT

      when "klausurergebnis"
        <<~TEXT
          [KLAURERGEBNIS]
          Matrikelnummer: #{r.matrikelnummer}
          Note: #{r.note}
          Status: #{r.status}
          Versuche: #{r.versuche}
          Prüfungsdatum: #{r.pruefungsdatum}
          Distanz: #{format("%.3f", r.distance)}
        TEXT
      
      # when "faq"
      #   <<~TEXT
      #     [FAQ]
      #     Frage: #{r.frage}
      #     Antwort: #{r.antwort}
      #     Distanz: #{format("%.3f", r.distance)}
      #   TEXT

      else
        "[UNBEKANNTER TYP] #{r.inspect}"
      end
    end.join("\n")
  end

  private

  def embed_with_openai(text)
    response = @client.embeddings(
      parameters: { model: "text-embedding-3-small", input: text }
    )
    response.dig("data", 0, "embedding")
  rescue => e
    Rails.logger.error "[RAG] OpenAI Embedding Error: #{e.message}"
    nil
  end

  def embedding_to_pgvector(arr)
    "[" + arr.map { |v| v.round(6) }.join(",") + "]"
  end
end