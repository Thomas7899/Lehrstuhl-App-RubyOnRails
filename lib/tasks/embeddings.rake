# lib/tasks/embeddings.rake
require "openai"

class Array
  def to_pgvector
    "[" + map { |v| v.round(6) }.join(",") + "]"
  end
end

namespace :embeddings do
  desc "Generiere OpenAI-Embeddings für alle Abschlussarbeiten (abstrakt + konkret)"
  task generate: :environment do
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
    model = "text-embedding-3-small"

    puts "➡️  Starte Generierung von Embeddings über OpenAI..."
    puts "   Modell: #{model}"

    total = AbstrakteAbschlussarbeit.count + KonkreteAbschlussarbeit.count
    processed = 0

    # --- Abstrakte Abschlussarbeiten ---
    AbstrakteAbschlussarbeit.find_each do |arbeit|
      text = [arbeit.thema, arbeit.themenskizze, arbeit.forschungsprojekt, arbeit.betreuer, arbeit.semester].compact.join(" - ")

      begin
        response = client.embeddings(parameters: { model:, input: text })
        embedding = response.dig("data", 0, "embedding")

        if embedding
          ActiveRecord::Base.connection.execute(
            ActiveRecord::Base.send(
              :sanitize_sql_array,
              ["UPDATE #{arbeit.class.table_name} SET embedding = ? WHERE id = ?", embedding.to_pgvector, arbeit.id]
            )
          )
          puts "🧩 Abstrakt gespeichert: #{arbeit.thema}"
        else
          puts "⚠️ Keine Embedding-Daten erhalten für '#{arbeit.thema}'"
        end
      rescue => e
        puts "❌ Fehler bei '#{arbeit.thema}': #{e.message}"
      end

      processed += 1
    end

    # --- Konkrete Abschlussarbeiten ---
    KonkreteAbschlussarbeit.find_each do |arbeit|
      text = [arbeit.angepasste_themenskizze, arbeit.gesetzte_schwerpunkte, arbeit.forschungsprojekt, arbeit.betreuer, arbeit.semester].compact.join(" - ")

      begin
        response = client.embeddings(parameters: { model:, input: text })
        embedding = response.dig("data", 0, "embedding")

        if embedding
          ActiveRecord::Base.connection.execute(
            ActiveRecord::Base.send(
              :sanitize_sql_array,
              ["UPDATE #{arbeit.class.table_name} SET embedding = ? WHERE id = ?", embedding.to_pgvector, arbeit.id]
            )
          )
          puts "🧩 Konkrete gespeichert: #{arbeit.matrikelnummer} (#{arbeit.forschungsprojekt})"
        else
          puts "⚠️ Keine Embedding-Daten erhalten für Matrikel #{arbeit.matrikelnummer}"
        end
      rescue => e
        puts "❌ Fehler bei Matrikel #{arbeit.matrikelnummer}: #{e.message}"
      end

      processed += 1
    end

    puts "✅ Embeddings wurden erfolgreich generiert!"
    puts "   Verarbeitete Datensätze: #{processed} / #{total}"
  end
end
