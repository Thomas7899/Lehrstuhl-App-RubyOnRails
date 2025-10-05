class CreateKonkreteAbschlussarbeits < ActiveRecord::Migration[8.0]
  def change
    create_table :konkrete_abschlussarbeits do |t|
      t.string :betreuer
      t.string :forschungsprojekt
      t.string :semester
      t.string :matrikelnummer
      t.string :angepasste_themenskizze
      t.string :gesetzte_schwerpunkte
      t.date :anmeldung_pruefungsamt
      t.date :abgabedatum
      t.integer :studienniveau
      t.integer :student_id

      t.timestamps
    end
  end
end
