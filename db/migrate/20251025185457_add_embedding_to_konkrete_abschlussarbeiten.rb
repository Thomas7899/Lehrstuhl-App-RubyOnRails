class AddEmbeddingToKonkreteAbschlussarbeiten < ActiveRecord::Migration[8.0]
  def change
    add_column :konkrete_abschlussarbeiten, :embedding, :vector, limit: 1536
  end
end
