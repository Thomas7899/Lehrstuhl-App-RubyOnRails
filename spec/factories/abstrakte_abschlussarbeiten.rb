# spec/factories/abstrakte_abschlussarbeits.rb
FactoryBot.define do
  factory :abstrakte_abschlussarbeit do
    betreuer { Faker::Name.name }
    forschungsprojekt { Faker::Lorem.sentence(word_count: 4) }
    semester { "#{rand(1..12)}. Semester" }
    thema { Faker::Lorem.sentence(word_count: 6) }
    themenskizze { Faker::Lorem.paragraph(sentence_count: 3) }
    projekt_id { rand(1..10) }
    created_at { Time.current }
    updated_at { Time.current }
  end
end