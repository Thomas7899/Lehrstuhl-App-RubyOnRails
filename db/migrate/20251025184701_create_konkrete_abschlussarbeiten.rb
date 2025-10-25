class CreateKonkreteAbschlussarbeiten < ActiveRecord::Migration[8.0]
  def change
    create_table :konkrete_abschlussarbeiten do |t|
      t.string :betreuer
      t.string :forschungsprojekt
      t.string :semester
      t.string :matrikelnummer
      t.string :angepasste_themenskizze
      t.string :gesetzte_schwerpunkte
      t.date :anmeldung_pruefungsamt
      t.date :abgabedatum
      t.integer :studienniveau
      t.references :student, foreign_key: true
      t.references :abstrakte_abschlussarbeit, foreign_key: { to_table: :abstrakte_abschlussarbeiten }


      t.timestamps
    end
  end
end
