class Student < ApplicationRecord
    def self.search(query)
        where(
          "vorname ILIKE :query OR nachname ILIKE :query OR matrikelnummer ILIKE :query OR email ILIKE :query",
          query: "%#{query}%"
        )
      end
    has_one :konkrete_abschlussarbeit
end
