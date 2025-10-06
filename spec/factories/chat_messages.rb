# spec/factories/chat_messages.rb
FactoryBot.define do
  factory :chat_message do
    # KORRIGIERT: Association mit Student (wird als 'user' referenziert)
    association :user, factory: :student
    content { Faker::Lorem.sentence(word_count: rand(5..15)) }
    role { ['user', 'assistant'].sample }
    created_at { Time.current }
    updated_at { Time.current }

    trait :from_user do
      role { 'user' }
    end

    trait :from_assistant do
      role { 'assistant' }
    end
  end
end