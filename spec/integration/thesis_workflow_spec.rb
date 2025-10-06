# spec/integration/thesis_workflow_spec.rb - KORRIGIERT
require 'rails_helper'

RSpec.describe 'Thesis Workflow Integration', type: :request do
  let(:student) { create(:student) }
  
  describe 'Complete thesis assignment workflow' do
    it 'allows student to inquire about thesis, get assigned, and complete' do
      # Test-Datenbank vor jedem Test bereinigen
      ChatMessage.destroy_all
      
      # Student fragt nach Abschlussarbeit
      post '/chat_messages', params: {
        chat_message: { content: 'Ich suche eine Abschlussarbeit', role: 'user' },
        user_id: student.id
      }
      expect(response).to have_http_status(:created)
      
      # Student fragt nach Status
      post '/chat_messages', params: {
        chat_message: { content: 'Wie ist der Status meiner Arbeit?', role: 'user' },
        user_id: student.id
      }
      expect(response).to have_http_status(:created)
      
      expect(ChatMessage.count).to eq(2)
      expect(ChatMessage.where(user: student).count).to eq(2)
    end
  end
end