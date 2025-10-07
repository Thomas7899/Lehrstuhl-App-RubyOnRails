require 'rails_helper'

RSpec.describe ChatMessagesController, type: :controller do
  let(:student) { create(:student) }

  describe 'GET #index' do
    let!(:messages) { create_list(:chat_message, 3, user: student) }
    let!(:other_messages) { create_list(:chat_message, 2) }

    it 'returns success response' do
      get :index, params: { user_id: student.id }
      expect(response).to be_successful
    end

    it 'returns messages as JSON' do
      get :index, params: { user_id: student.id }
      expect(response.content_type).to include('application/json')
    end

    it 'returns only messages for the specific student' do
      get :index, params: { user_id: student.id }
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(3)

      json_response.each do |msg|
        expect(msg['user_id']).to eq(student.id)
      end
    end

    it 'returns 404 for non-existent student' do
      get :index, params: { user_id: 99999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    context 'with valid nested parameters' do
      let(:valid_attributes) do
        { content: 'Hello, I have a question about my thesis', role: 'user' }
      end

      it 'creates a new ChatMessage' do
        expect {
          post :create, params: {
            chat_message: valid_attributes,
            user_id: student.id
          }
        }.to change(ChatMessage, :count).by(1)
      end

      it 'returns created status' do
        post :create, params: {
          chat_message: valid_attributes,
          user_id: student.id
        }
        expect(response).to have_http_status(:created)
      end

      it 'returns the created message as JSON' do
        post :create, params: {
          chat_message: valid_attributes,
          user_id: student.id
        }
        json_response = JSON.parse(response.body)
        expect(json_response['content']).to eq('Hello, I have a question about my thesis')
        expect(json_response['role']).to eq('user')
      end

      it 'associates message with correct student' do
        post :create, params: {
          chat_message: valid_attributes,
          user_id: student.id
        }
        expect(ChatMessage.last.user).to eq(student)
      end
    end

    context 'with valid flat parameters' do
      it 'creates a new ChatMessage' do
        expect {
          post :create, params: {
            content: 'This is a flat message',
            role: 'user',
            user_id: student.id
          }
        }.to change(ChatMessage, :count).by(1)
      end

      it 'returns created status' do
        post :create, params: {
          content: 'This is a flat message',
          role: 'user',
          user_id: student.id
        }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        { content: '', role: 'invalid_role' }
      end

      it 'does not create a new ChatMessage' do
        expect {
          post :create, params: {
            chat_message: invalid_attributes,
            user_id: student.id
          }
        }.to change(ChatMessage, :count).by(0)
      end

      it 'returns unprocessable content status' do
        post :create, params: {
          chat_message: invalid_attributes,
          user_id: student.id
        }
        expect(response).to have_http_status(:unprocessable_content)
      end

      it 'returns validation errors' do
        post :create, params: {
          chat_message: invalid_attributes,
          user_id: student.id
        }
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('content')
      end
    end

    context 'with missing chat_message parameter' do
      it 'returns a 400 bad_request status' do
        post :create, params: { user_id: student.id }
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns a helpful error message' do
        post :create, params: { user_id: student.id }
        json_response = JSON.parse(response.body)
        # KORRIGIERT: Erwartet jetzt die neue, präzisere Fehlermeldung vom Controller.
        expect(json_response['error']).to eq("Invalid or missing parameters")
        expect(json_response['details']).to include("Request must include either a nested 'chat_message' object or flat 'content' and 'role' parameters.")
      end

      it 'does not create a new ChatMessage' do
        expect {
          post :create, params: { user_id: student.id }
        }.not_to change(ChatMessage, :count)
      end
    end

    context 'with invalid student' do
      it 'returns 404 for non-existent student' do
        post :create, params: {
          chat_message: { content: 'Test', role: 'user' },
          user_id: 99999
        }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET #show' do
    let(:message) { create(:chat_message, user: student) }

    it 'returns success response' do
      get :show, params: { id: message.id, user_id: student.id }
      expect(response).to be_successful
    end

    it 'returns the message as JSON' do
      get :show, params: { id: message.id, user_id: student.id }
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(message.id)
      expect(json_response['content']).to eq(message.content)
    end

    it 'returns 404 for non-existent message' do
      get :show, params: { id: 99999, user_id: student.id }
      expect(response).to have_http_status(:not_found)
    end
  end
end
