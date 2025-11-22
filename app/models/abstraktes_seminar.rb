class AbstraktesSeminar < ApplicationRecord
  self.table_name = 'abstrakte_seminare'

  belongs_to :mitarbeiter
  has_many :seminare, foreign_key: 'abstraktes_seminar_id', dependent: :destroy, inverse_of: :abstraktes_seminar
end