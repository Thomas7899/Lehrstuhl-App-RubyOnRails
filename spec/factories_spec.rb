# spec/factories_spec.rb
require 'rails_helper'

RSpec.describe 'Factories' do
  describe 'student factory' do
    it 'creates a valid student' do
      student = build(:student)
      expect(student).to be_valid
    end

    it 'creates and saves a student' do
      expect { create(:student) }.to change(Student, :count).by(1)
    end

    it 'has correct attributes' do
      student = create(:student)
      expect(student.vorname).to be_present
      expect(student.nachname).to be_present
      expect(student.email).to be_present
      expect(student.matrikelnummer).to be_present
      expect(student.geburtsdatum).to be_present
    end
  end

  describe 'user factory' do
    it 'creates a valid user' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'creates and saves a user' do
      expect { create(:user) }.to change(User, :count).by(1)
    end

    it 'has correct attributes' do
      user = create(:user)
      expect(user.email_address).to be_present
      expect(user.password_digest).to be_present
    end
  end

  describe 'session factory' do
    it 'creates a valid session' do
      session = build(:session)
      expect(session).to be_valid
    end

    it 'creates and saves a session' do
      expect { create(:session) }.to change(Session, :count).by(1)
    end

    it 'has associated user' do
      session = create(:session)
      expect(session.user).to be_present
      expect(session.ip_address).to be_present
    end
  end

  describe 'chat_message factory' do
    it 'creates a valid chat message' do
      message = build(:chat_message)
      expect(message).to be_valid
    end

    it 'creates and saves a chat message' do
      expect { create(:chat_message) }.to change(ChatMessage, :count).by(1)
    end

    it 'has correct attributes' do
      message = create(:chat_message)
      expect(message.content).to be_present
      expect(message.role).to be_present
      expect(message.user).to be_a(Student)  # User referenziert Student
    end

    it 'creates message from user' do
      message = create(:chat_message, :from_user)
      expect(message.role).to eq('user')
    end

    it 'creates message from assistant' do
      message = create(:chat_message, :from_assistant)
      expect(message.role).to eq('assistant')
    end
  end

  describe 'konkrete_abschlussarbeit factory' do
    it 'creates a valid konkrete_abschlussarbeit' do
      arbeit = build(:konkrete_abschlussarbeit)
      expect(arbeit).to be_valid
    end

    it 'creates and saves a konkrete_abschlussarbeit' do
      expect { create(:konkrete_abschlussarbeit) }.to change(KonkreteAbschlussarbeit, :count).by(1)
    end

    it 'has associated student' do
      arbeit = create(:konkrete_abschlussarbeit)
      expect(arbeit.student_id).to be_present
      expect(Student.find(arbeit.student_id)).to be_present
    end
  end

  describe 'abstrakte_abschlussarbeit factory' do
    it 'creates a valid abstrakte_abschlussarbeit' do
      arbeit = build(:abstrakte_abschlussarbeit)
      expect(arbeit).to be_valid
    end

    it 'creates and saves a abstrakte_abschlussarbeit' do
      expect { create(:abstrakte_abschlussarbeit) }.to change(AbstrakteAbschlussarbeit, :count).by(1)
    end
  end
end