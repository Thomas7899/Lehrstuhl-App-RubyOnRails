class KonkreteAbschlussarbeit < ApplicationRecord
    belongs_to :student
    belongs_to :abstrakte_abschlussarbeit, optional: true
    enum :studienniveau, [:bachelor, :master, :diplom]
end
