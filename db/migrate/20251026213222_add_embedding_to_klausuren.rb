class AddEmbeddingToKlausuren < ActiveRecord::Migration[8.0]
 def change
    enable_extension "vector" unless extension_enabled?("vector")

    add_column :klausuren, :embedding, :vector, limit: 1536
    add_index :klausuren, :embedding, using: :ivfflat, opclass: :vector_l2_ops
  end
end