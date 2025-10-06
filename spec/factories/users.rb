# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email_address { Faker::Internet.unique.email }
    password_digest { BCrypt::Password.create('password123') }
    created_at { Time.current }
    updated_at { Time.current }
  end
end