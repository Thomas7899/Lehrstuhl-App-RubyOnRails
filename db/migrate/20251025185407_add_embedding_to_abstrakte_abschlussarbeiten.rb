class AddEmbeddingToAbstrakteAbschlussarbeiten < ActiveRecord::Migration[8.0]
  def change
    add_column :abstrakte_abschlussarbeiten, :embedding, :vector, limit: 1536
  end
end
