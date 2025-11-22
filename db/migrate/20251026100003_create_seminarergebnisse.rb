class CreateSeminarergebnisse < ActiveRecord::Migration[8.0]
  def change
    create_table :seminarergebnisse, id: :uuid do |t|
      t.float :muendlich_note
      t.float :schriftlich_note
      t.float :gesamt
      t.integer :versuche, default: 0
      t.references :student, foreign_key: true # Verweist auf bigint PK von students
      t.references :seminar, type: :uuid, foreign_key: { to_table: :seminare }

      t.timestamps
    end
    add_index :seminarergebnisse, [:student_id, :seminar_id], unique: true
  end
end