# spec/system/chat_spec.rb - ENTFERNEN oder korrigieren
# Da wir keine HTML-Views haben, System-Tests entfernen:
rm spec/system/chat_spec.rb

# Oder wenn du Frontend-Tests willst:
# spec/system/chat_api_spec.rb
require 'rails_helper'

RSpec.describe 'Chat API Integration', type: :system do
  let(:student) { create(:student) }

  it 'can create and retrieve messages via API' do
    # API-Calls testen statt DOM-Manipulation
    page.driver.post('/chat_messages', {
      chat_message: { content: 'Test', role: 'user' },
      user_id: student.id
    }.to_json, { 'CONTENT_TYPE' => 'application/json' })

    expect(page.driver.response.status).to eq(201)
  end
end
