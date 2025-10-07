# spec/models/student_spec.rb
require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:vorname) }
    it { should validate_presence_of(:nachname) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:matrikelnummer) }

    # KORRIGIERT: Für numerische Matrikelnummer
    describe 'matrikelnummer uniqueness' do
      it 'validates uniqueness of matrikelnummer' do
        student1 = create(:student, matrikelnummer: '12345678')
        student2 = build(:student, matrikelnummer: '12345678')

        expect(student2).not_to be_valid
        expect(student2.errors[:matrikelnummer]).to include('has already been taken')
      end

      it 'allows different matrikelnummer' do
        create(:student, matrikelnummer: '12345678')
        student2 = build(:student, matrikelnummer: '87654321')

        expect(student2).to be_valid
      end
    end
  end

  describe 'factory' do
    it 'creates a valid student' do
      expect(build(:student)).to be_valid
    end
  end

  describe 'instance methods' do
    let(:student) { create(:student, vorname: 'Max', nachname: 'Mustermann') }

    describe '#full_name' do
      it 'returns the full name' do
        expect(student.full_name).to eq('Max Mustermann')
      end
    end

    describe '#display_name' do
      it 'returns the display name' do
        expect(student.display_name).to eq('Max Mustermann')
      end
    end
  end

  describe 'associations' do
    it { should have_one(:konkrete_abschlussarbeit).dependent(:destroy) }
    it { should have_many(:chat_messages).with_foreign_key('user_id').dependent(:destroy) }
  end

  describe 'search functionality' do
    let!(:student1) { create(:student, vorname: 'Max', nachname: 'Mustermann', matrikelnummer: '12345678') }
    let!(:student2) { create(:student, vorname: 'Anna', nachname: 'Schmidt', matrikelnummer: '87654321') }

    it 'finds students by vorname' do
      results = Student.search('Max')
      expect(results).to include(student1)
      expect(results).not_to include(student2)
    end

    it 'finds students by nachname' do
      results = Student.search('Schmidt')
      expect(results).to include(student2)
      expect(results).not_to include(student1)
    end

    it 'finds students by matrikelnummer' do
      results = Student.search('12345')
      expect(results).to include(student1)
      expect(results).not_to include(student2)
    end

    it 'is case insensitive' do
      results = Student.search('max')
      expect(results).to include(student1)
    end
  end
end
