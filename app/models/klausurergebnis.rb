class Klausurergebnis < ApplicationRecord
  self.table_name = 'klausurergebnisse'

  belongs_to :student
  belongs_to :klausur

  validates :student_id, uniqueness: { scope: :klausur_id, message: "hat bereits ein Ergebnis für diese Klausur" }
end