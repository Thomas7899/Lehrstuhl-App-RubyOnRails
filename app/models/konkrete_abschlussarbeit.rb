class KonkreteAbschlussarbeit < ApplicationRecord
    def self.search(query)
        where(
          "betreuer ILIKE :query OR matrikelnummer ILIKE :query",
          query: "%#{query}%"
        )
      end
    
    belongs_to :student
    belongs_to :abstrakte_abschlussarbeit, optional: true
    enum :studienniveau, [:bachelor, :master, :diplom]
end
