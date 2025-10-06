# app/models/chat_message.rb
class ChatMessage < ApplicationRecord
  belongs_to :user, class_name: 'Student', foreign_key: 'user_id'
  
  validates :content, presence: true, length: { maximum: 5000 }
  validates :role, inclusion: { in: %w[user assistant system] }
  
  scope :recent, -> { order(created_at: :desc).limit(50) }
  scope :by_user, ->(user) { where(user: user) }
  scope :conversation_history, ->(user) { by_user(user).order(:created_at) }
  
  def formatted_timestamp
    created_at.strftime('%H:%M')
  end
  
  def is_from_user?
    role == 'user'
  end
  
  def is_from_assistant?
    role == 'assistant'
  end
end