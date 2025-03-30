class AddProjektIdToKonkreteAbschlussarbeits < ActiveRecord::Migration[8.0]
  def change
    add_column :konkrete_abschlussarbeits, :projekt_id, :integer
  end
end
