class Klausur < ApplicationRecord
  self.table_name = 'klausuren'

  has_many :klausurergebnisse, dependent: :destroy
  has_many :students, through: :klausurergebnisse
end