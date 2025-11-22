class CreateAbstrakteSeminare < ActiveRecord::Migration[8.0]
  def change
    create_table :abstrakte_seminare, id: :uuid do |t|
      t.string :thema
      t.text :beschreibung
      t.references :mitarbeiter, type: :uuid, foreign_key: { to_table: :mitarbeiter }

      t.timestamps
    end
  end
end