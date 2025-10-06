# spec/models/chat_message_spec.rb
require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('Student') }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(5000) }
    it { should validate_inclusion_of(:role).in_array([ 'user', 'assistant', 'system' ]) }
  end

  describe 'factory' do
    it 'creates a valid chat message' do
      message = build(:chat_message)
      expect(message).to be_valid
    end
  end

  describe 'scopes' do
    let(:student) { create(:student) }
    let!(:user_message) { create(:chat_message, :from_user, user: student) }
    let!(:assistant_message) { create(:chat_message, :from_assistant, user: student) }

    it 'filters by user' do
      messages = ChatMessage.by_user(student)
      expect(messages).to include(user_message, assistant_message)
    end

    it 'returns recent messages' do
      recent_messages = ChatMessage.recent
      expect(recent_messages.first.created_at).to be >= recent_messages.last.created_at
    end
  end

  describe 'instance methods' do
    let(:user_message) { create(:chat_message, :from_user) }
    let(:assistant_message) { create(:chat_message, :from_assistant) }

    describe '#is_from_user?' do
      it 'returns true for user messages' do
        expect(user_message.is_from_user?).to be true
      end

      it 'returns false for assistant messages' do
        expect(assistant_message.is_from_user?).to be false
      end
    end

    describe '#is_from_assistant?' do
      it 'returns true for assistant messages' do
        expect(assistant_message.is_from_assistant?).to be true
      end

      it 'returns false for user messages' do
        expect(user_message.is_from_assistant?).to be false
      end
    end

    describe '#formatted_timestamp' do
      it 'returns formatted time' do
        message = create(:chat_message)
        expect(message.formatted_timestamp).to match(/\d{2}:\d{2}/)
      end
    end
  end
end
