class CreateChatMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_messages do |t|
      t.references :user, null: false, foreign_key: { to_table: :students }
      t.text :content, null: false
      t.string :role, null: false, default: 'user'

      t.timestamps
    end

    add_index :chat_messages, [ :user_id, :created_at ]
    add_index :chat_messages, :role
  end
end
