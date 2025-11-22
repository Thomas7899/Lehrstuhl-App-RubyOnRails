class Mitarbeiter < ApplicationRecord
  # Setzt den Tabellennamen explizit, falls er von der Rails-Konvention abweicht.
  self.table_name = 'mitarbeiter'

  # Assoziationen: Ein Mitarbeiter kann mehrere Seminare und abstrakte Seminare haben.
  # dependent: :nullify sorgt dafür, dass beim Löschen eines Mitarbeiters die Referenz in den
  # zugehörigen Seminaren auf NULL gesetzt wird, anstatt die Seminare zu löschen.
  has_many :abstrakte_seminare, dependent: :nullify
  has_many :seminare, dependent: :nullify
end