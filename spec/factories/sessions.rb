# spec/factories/sessions.rb
FactoryBot.define do
  factory :session do
    association :user, factory: :user
    ip_address { Faker::Internet.ip_v4_address }
    user_agent { Faker::Internet.user_agent }
    created_at { Time.current }
    updated_at { Time.current }
  end
end