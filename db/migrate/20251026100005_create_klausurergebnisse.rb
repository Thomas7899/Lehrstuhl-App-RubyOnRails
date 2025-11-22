class CreateKlausurergebnisse < ActiveRecord::Migration[8.0]
  def change
    create_table :klausurergebnisse, id: :uuid do |t|
      t.integer :punkte
      t.float :note
      t.string :status
      t.date :pruefungsdatum
      t.integer :versuche, default: 0
      t.references :student, foreign_key: true # Verweist auf bigint PK von students
      t.references :klausur, type: :uuid, foreign_key: { to_table: :klausuren }

      t.timestamps
    end
  end
end