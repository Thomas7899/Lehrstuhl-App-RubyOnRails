class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :email
      t.string :matrikelnummer
      t.string :vorname
      t.string :nachname
      t.date :geburtsdatum

      t.timestamps
    end
  end
end
