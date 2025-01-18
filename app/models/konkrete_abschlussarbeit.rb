class KonkreteAbschlussarbeit < ApplicationRecord
    belongs_to :student
    enum :studienniveau, [:bachelor, :master, :diplom]
end
