class Seminarergebnis < ApplicationRecord
  self.table_name = 'seminarergebnisse'

  belongs_to :student
  belongs_to :seminar

  validates :student_id, uniqueness: { scope: :seminar_id, message: "kann nicht mehrmals am selben Seminar teilnehmen" }
end