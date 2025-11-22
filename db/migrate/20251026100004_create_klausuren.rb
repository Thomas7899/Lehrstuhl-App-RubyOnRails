class CreateKlausuren < ActiveRecord::Migration[8.0]
  def change
    create_table :klausuren, id: :uuid do |t|
      t.string :titel
      t.string :modul
      t.string :semester

      t.timestamps
    end
  end
end