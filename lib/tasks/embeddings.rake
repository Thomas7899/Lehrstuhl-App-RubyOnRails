# lib/tasks/embeddings.rake
require "openai"

class Array
  def to_pgvector
    "[" + map { |v| v.round(6) }.join(",") + "]"
  end
end

namespace :embeddings do
  desc "Generiere OpenAI-Embeddings für Abschlussarbeiten, Seminare und Klausuren"
  task generate: :environment do
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
    model = "text-embedding-3-small"

    puts "➡️  Starte Generierung von Embeddings über OpenAI..."
    puts "   Modell: #{model}"

    total = AbstrakteAbschlussarbeit.count +
             KonkreteAbschlussarbeit.count +
             AbstraktesSeminar.count +
             Seminar.count +
             Klausur.count

    processed = 0

    # --- Abstrakte Abschlussarbeiten ---
    puts "\n📘 Abschnitt 1: Abstrakte Abschlussarbeiten"
    AbstrakteAbschlussarbeit.find_each do |arbeit|
      text = [arbeit.thema, arbeit.themenskizze, arbeit.forschungsprojekt, arbeit.betreuer, arbeit.semester].compact.join(" - ")

      begin
        response = client.embeddings(parameters: { model:, input: text })
        embedding = response.dig("data", 0, "embedding")

        if embedding
          ActiveRecord::Base.connection.execute(
            ActiveRecord::Base.send(:sanitize_sql_array,
              ["UPDATE #{arbeit.class.table_name} SET embedding = ? WHERE id = ?", embedding.to_pgvector, arbeit.id])
          )
          puts "🧩 Abstrakt gespeichert: #{arbeit.thema}"
        end
      rescue => e
        puts "❌ Fehler bei '#{arbeit.thema}': #{e.message}"
      end
      processed += 1
    end

    # --- Konkrete Abschlussarbeiten ---
    puts "\n📗 Abschnitt 2: Konkrete Abschlussarbeiten"
    KonkreteAbschlussarbeit.find_each do |arbeit|
      text = [arbeit.angepasste_themenskizze, arbeit.gesetzte_schwerpunkte, arbeit.forschungsprojekt, arbeit.betreuer, arbeit.semester].compact.join(" - ")
      begin
        response = client.embeddings(parameters: { model:, input: text })
        embedding = response.dig("data", 0, "embedding")
        if embedding
          ActiveRecord::Base.connection.execute(
            ActiveRecord::Base.send(:sanitize_sql_array,
              ["UPDATE #{arbeit.class.table_name} SET embedding = ? WHERE id = ?", embedding.to_pgvector, arbeit.id])
          )
          puts "🧩 Konkrete gespeichert: #{arbeit.matrikelnummer}"
        end
      rescue => e
        puts "❌ Fehler bei Matrikel #{arbeit.matrikelnummer}: #{e.message}"
      end
      processed += 1
    end

    # --- Abstrakte Seminare ---
    puts "\n📙 Abschnitt 3: Abstrakte Seminare"
    AbstraktesSeminar.find_each do |seminar|
      text = [seminar.thema, seminar.beschreibung].compact.join(" - ")
      begin
        response = client.embeddings(parameters: { model:, input: text })
        embedding = response.dig("data", 0, "embedding")
        if embedding
          ActiveRecord::Base.connection.execute(
            ActiveRecord::Base.send(:sanitize_sql_array,
              ["UPDATE #{seminar.class.table_name} SET embedding = ? WHERE id = ?", embedding.to_pgvector, seminar.id])
          )
          puts "🧩 Abstraktes Seminar gespeichert: #{seminar.thema}"
        end
      rescue => e
        puts "❌ Fehler bei '#{seminar.thema}': #{e.message}"
      end
      processed += 1
    end

    # --- Seminare ---
    puts "\n📒 Abschnitt 4: Seminare"
    Seminar.find_each do |seminar|
      text = [seminar.titel, seminar.semester, seminar.ort,
              seminar.abstraktes_seminar&.thema,
              seminar.abstraktes_seminar&.beschreibung].compact.join(" - ")
      begin
        response = client.embeddings(parameters: { model:, input: text })
        embedding = response.dig("data", 0, "embedding")
        if embedding
          ActiveRecord::Base.connection.execute(
            ActiveRecord::Base.send(:sanitize_sql_array,
              ["UPDATE #{seminar.class.table_name} SET embedding = ? WHERE id = ?", embedding.to_pgvector, seminar.id])
          )
          puts "🧩 Seminar gespeichert: #{seminar.titel}"
        end
      rescue => e
        puts "❌ Fehler bei Seminar '#{seminar.titel}': #{e.message}"
      end
      processed += 1
    end

    # --- Klausuren ---
    puts "\n📕 Abschnitt 5: Klausuren"
    Klausur.find_each do |klausur|
      text = [klausur.titel, klausur.modul, klausur.semester].compact.join(" - ")
      begin
        response = client.embeddings(parameters: { model:, input: text })
        embedding = response.dig("data", 0, "embedding")
        if embedding
          ActiveRecord::Base.connection.execute(
            ActiveRecord::Base.send(:sanitize_sql_array,
              ["UPDATE #{klausur.class.table_name} SET embedding = ? WHERE id = ?", embedding.to_pgvector, klausur.id])
          )
          puts "🧩 Klausur gespeichert: #{klausur.titel}"
        end
      rescue => e
        puts "❌ Fehler bei Klausur '#{klausur.titel}': #{e.message}"
      end
      processed += 1
    end

    puts "\n✅ Embeddings wurden erfolgreich generiert!"
    puts "   Verarbeitete Datensätze: #{processed} / #{total}"
  end
end
