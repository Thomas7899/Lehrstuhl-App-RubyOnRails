class Seminar < ApplicationRecord
  self.table_name = 'seminare'

  belongs_to :abstraktes_seminar
  belongs_to :mitarbeiter

  has_many :seminarergebnisse, class_name: "Seminarergebnis", dependent: :destroy
  has_many :students, through: :seminarergebnisse
end