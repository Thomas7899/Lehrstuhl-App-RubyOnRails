class CreateSeminare < ActiveRecord::Migration[8.0]
  def change
    create_table :seminare, id: :uuid do |t|
      t.string :titel
      t.integer :aufnahmekapazitaet
      t.string :semester
      t.date :praesenzdatum
      t.string :ort
      t.references :mitarbeiter, type: :uuid, foreign_key: { to_table: :mitarbeiter }
      t.references :abstraktes_seminar, type: :uuid, foreign_key: { to_table: :abstrakte_seminare }

      t.timestamps
    end
  end
end