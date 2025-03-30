class AbstrakteAbschlussarbeit < ApplicationRecord
    def self.search(query)
        where(
          "thema ILIKE :query OR forschungsprojekt ILIKE :query",
          query: "%#{query}%"
        )
      end
    has_many :konkrete_abschlussarbeit
end
