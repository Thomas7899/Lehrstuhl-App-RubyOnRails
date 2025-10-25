class KonkreteAbschlussarbeit < ApplicationRecord
  self.table_name = "konkrete_abschlussarbeiten"

  belongs_to :student
  belongs_to :abstrakte_abschlussarbeit, foreign_key: :abstrakte_abschlussarbeit_id, optional: true

  enum :studienniveau, [:bachelor, :master, :diplom]

  def self.search(query)
    where("betreuer ILIKE :query OR matrikelnummer ILIKE :query", query: "%#{query}%")
  end
end
