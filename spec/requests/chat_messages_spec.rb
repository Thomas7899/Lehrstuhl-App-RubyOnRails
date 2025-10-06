require 'rails_helper'

RSpec.describe "ChatMessages API", type: :request do
  let(:student) { create(:student) }

  describe "GET /chat_messages" do
    it "returns http success" do
      get "/chat_messages", params: { user_id: student.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /chat_messages" do
    it "creates a chat message" do
      post "/chat_messages", params: {
        chat_message: { content: 'Test message', role: 'user' },
        user_id: student.id
      }
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /chat_messages/:id" do
    let(:message) { create(:chat_message, user: student) }
    
    it "returns the message" do
      get "/chat_messages/#{message.id}", params: { user_id: student.id }
      expect(response).to have_http_status(:success)
    end
  end
end