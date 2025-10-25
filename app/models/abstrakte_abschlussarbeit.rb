class AbstrakteAbschlussarbeit < ApplicationRecord
  self.table_name = "abstrakte_abschlussarbeiten"

  has_many :konkrete_abschlussarbeiten,
           foreign_key: :abstrakte_abschlussarbeit_id,
           dependent: :nullify

  def self.search(query)
    where("thema ILIKE :q OR forschungsprojekt ILIKE :q", q: "%#{query}%")
  end

  def embedding_text
    [thema, themenskizze, forschungsprojekt, betreuer, semester]
      .compact
      .join(" – ")
  end
end

