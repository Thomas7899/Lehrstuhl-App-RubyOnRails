class CreateAbstrakteAbschlussarbeits < ActiveRecord::Migration[8.0]
  def change
    create_table :abstrakte_abschlussarbeits do |t|
      t.string :betreuer
      t.string :forschungsprojekt
      t.string :semester
      t.string :thema
      t.string :themenskizze
      t.integer :projekt_id

      t.timestamps
    end
  end
end
