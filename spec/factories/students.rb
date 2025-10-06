# spec/factories/students.rb
FactoryBot.define do
  factory :student do
    vorname { Faker::Name.first_name }
    nachname { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    matrikelnummer { Faker::Number.unique.number(digits: 8).to_s }
    geburtsdatum { Faker::Date.between(from: 25.years.ago, to: 18.years.ago) }
    created_at { Time.current }
    updated_at { Time.current }
  end
end