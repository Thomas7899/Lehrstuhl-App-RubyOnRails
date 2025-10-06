# spec/factories/konkrete_abschlussarbeits.rb
FactoryBot.define do
  factory :konkrete_abschlussarbeit do
    betreuer { Faker::Name.name }
    forschungsprojekt { Faker::Lorem.sentence(word_count: 4) }
    semester { "#{rand(1..12)}. Semester" }
    matrikelnummer { Faker::Number.unique.number(digits: 8).to_s }
    angepasste_themenskizze { Faker::Lorem.paragraph(sentence_count: 2) }
    gesetzte_schwerpunkte { Faker::Lorem.paragraph(sentence_count: 1) }
    anmeldung_pruefungsamt { Faker::Date.between(from: 6.months.ago, to: Date.current) }
    abgabedatum { Faker::Date.between(from: Date.current, to: 6.months.from_now) }
    studienniveau { [1, 2].sample }  # 1=Bachelor, 2=Master
    student_id { create(:student).id }
    created_at { Time.current }
    updated_at { Time.current }
  end
end