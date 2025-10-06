# spec/performance/chat_performance_spec.rb - KORRIGIERT
require 'rails_helper'

RSpec.describe 'Chat Performance', type: :request do
  let(:student) { create(:student) }

  describe 'Chat message creation performance' do
    it 'creates messages efficiently' do
      start_time = Time.current

      10.times do
        create(:chat_message, user: student)
      end

      end_time = Time.current
      execution_time = end_time - start_time

      expect(execution_time).to be < 1.0  # Weniger als 1 Sekunde
    end

    it 'loads chat history efficiently' do
      create_list(:chat_message, 50, user: student)

      start_time = Time.current
      get '/chat_messages', params: { user_id: student.id }
      end_time = Time.current

      execution_time = end_time - start_time
      expect(response).to be_successful
      expect(execution_time).to be < 0.5  # Weniger als 500ms
    end
  end
end
