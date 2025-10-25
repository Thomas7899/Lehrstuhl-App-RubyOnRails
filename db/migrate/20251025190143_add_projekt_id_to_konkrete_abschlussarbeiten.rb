class AddProjektIdToKonkreteAbschlussarbeiten < ActiveRecord::Migration[8.0]
  def change
    add_column :konkrete_abschlussarbeiten, :projekt_id, :integer
  end
end
