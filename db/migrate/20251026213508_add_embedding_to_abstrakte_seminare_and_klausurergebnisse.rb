class AddEmbeddingToAbstrakteSeminareAndKlausurergebnisse < ActiveRecord::Migration[8.0]
  def change
    # 🧩 pgvector-Extension aktivieren (nur einmal notwendig)
    enable_extension "vector" unless extension_enabled?("vector")

    # 🧠 Abstrakte Seminare
    add_column :abstrakte_seminare, :embedding, :vector, limit: 1536
    add_index  :abstrakte_seminare, :embedding, using: :ivfflat, opclass: :vector_l2_ops

    # 🧮 Klausurergebnisse
    add_column :klausurergebnisse, :embedding, :vector, limit: 1536
    add_index  :klausurergebnisse, :embedding, using: :ivfflat, opclass: :vector_l2_ops
  end
end
