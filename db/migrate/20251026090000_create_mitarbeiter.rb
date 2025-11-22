class CreateMitarbeiter < ActiveRecord::Migration[8.0]
  def change
    create_table :mitarbeiter, id: :uuid do |t|
      t.string :vorname
      t.string :nachname
      t.string :email, null: false
      t.string :titel

      t.timestamps
    end
    add_index :mitarbeiter, :email, unique: true
  end
end