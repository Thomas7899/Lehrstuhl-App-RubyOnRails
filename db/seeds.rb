# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.find_or_create_by!(email_address: "admin@example.de") do |user|
  user.password = "password"
end

Student.create!(
    email: "thomas@web.de", 
    matrikelnummer: "7947810", 
    vorname:"Thomas", 
    nachname:"Osterlehner", 
    geburtsdatum: DateTime.new(1990,5,2))

Student.create!(
    email: "sabine@web.de", 
    matrikelnummer: "123456", 
    vorname:"Sabine", 
    nachname:"Musterfrau", 
    geburtsdatum: DateTime.new(2000,9,14))

Student.create!(
    email: "sascha@web.de", 
    matrikelnummer: "122456", 
    vorname:"Sascha", 
    nachname:"Mustermann", 
    geburtsdatum: DateTime.new(1999,5,12))

Student.create!(
    email: "julia.schmidt@example.com",
    matrikelnummer: "123456",
    vorname: "Julia",
    nachname: "Schmidt",
    geburtsdatum: DateTime.new(2001, 8, 24)
  )
  
  Student.create!(
    email: "max.mueller@example.com",
    matrikelnummer: "654321",
    vorname: "Max",
    nachname: "Müller",
    geburtsdatum: DateTime.new(2000, 3, 15)
  )

  Student.create!(
    email: "lena.meier@example.com",
    matrikelnummer: "789123",
    vorname: "Lena",
    nachname: "Meier",
    geburtsdatum: DateTime.new(1998, 12, 5)
  )
  
  Student.create!(
    email: "paul.bauer@example.com",
    matrikelnummer: "987654",
    vorname: "Paul",
    nachname: "Bauer",
    geburtsdatum: DateTime.new(1997, 7, 18)
  )
  
  Student.create!(
    email: "anna.fischer@example.com",
    matrikelnummer: "321987",
    vorname: "Anna",
    nachname: "Fischer",
    geburtsdatum: DateTime.new(2002, 1, 30)
  )
  
  Student.create!(
  email: "benjamin.keller@example.com",
  matrikelnummer: "458721",
  vorname: "Benjamin",
  nachname: "Keller",
  geburtsdatum: DateTime.new(2000, 11, 22)
)

Student.create!(
  email: "sophie.huber@example.com",
  matrikelnummer: "102348",
  vorname: "Sophie",
  nachname: "Huber",
  geburtsdatum: DateTime.new(1999, 4, 17)
)

Student.create!(
  email: "lucas.braun@example.com",
  matrikelnummer: "847263",
  vorname: "Lucas",
  nachname: "Braun",
  geburtsdatum: DateTime.new(2001, 6, 9)
)

Student.create!(
  email: "emma.vogel@example.com",
  matrikelnummer: "394857",
  vorname: "Emma",
  nachname: "Vogel",
  geburtsdatum: DateTime.new(1998, 10, 25)
)

Student.create!(
  email: "leo.mayer@example.com",
  matrikelnummer: "574839",
  vorname: "Leo",
  nachname: "Mayer",
  geburtsdatum: DateTime.new(1997, 8, 14)
)

Student.create!(
  email: "mia.schneider@example.com",
  matrikelnummer: "756293",
  vorname: "Mia",
  nachname: "Schneider",
  geburtsdatum: DateTime.new(2002, 3, 11)
)

Student.create!(
  email: "jonas.bauer@example.com",
  matrikelnummer: "192837",
  vorname: "Jonas",
  nachname: "Bauer",
  geburtsdatum: DateTime.new(2000, 12, 29)
)

Student.create!(
  email: "lara.fischer@example.com",
  matrikelnummer: "384759",
  vorname: "Lara",
  nachname: "Fischer",
  geburtsdatum: DateTime.new(1999, 9, 2)
)

Student.create!(
  email: "alexander.wolf@example.com",
  matrikelnummer: "918273",
  vorname: "Alexander",
  nachname: "Wolf",
  geburtsdatum: DateTime.new(2001, 1, 15)
)

Student.create!(
  email: "amelie.becker@example.com",
  matrikelnummer: "564738",
  vorname: "Amelie",
  nachname: "Becker",
  geburtsdatum: DateTime.new(1996, 7, 4)
)

AbstrakteAbschlussarbeit.create!([
  {
    betreuer: "Dr. Schmidt",
    forschungsprojekt: "AI in Healthcare",
    semester: "Winter 2024",
    thema: "Exploring the use of AI for diagnostics",
    themenskizze: "Machine Learning, Ethics, Data Privacy",
    projekt_id: 1
  },
  {
    betreuer: "Dr. Schmidt",
    forschungsprojekt: "AI in Healthcare",
    semester: "Winter 2024",
    thema: "Exploring the use of AI for diagnostics",
    themenskizze: "Machine Learning, Ethics, Data Privacy",
    projekt_id: 2
  }])


KonkreteAbschlussarbeit.create!([
  {
    betreuer: "Dr. Schmidt",
    forschungsprojekt: "AI in Healthcare",
    semester: "Winter 2024",
    matrikelnummer: "654321",
    angepasste_themenskizze: "Exploring the use of AI for diagnostics",
    gesetzte_schwerpunkte: "Machine Learning, Ethics, Data Privacy",
    anmeldung_pruefungsamt: Date.new(2024, 1, 15),
    abgabedatum: Date.new(2024, 6, 15),
    studienniveau: "bachelor",
    student_id: 5,
    projekt_id: 1
  },
  {
    betreuer: "Prof. Müller",
    forschungsprojekt: "Renewable Energy Optimization",
    semester: "Summer 2024",
    matrikelnummer: "122456",
    angepasste_themenskizze: "Optimizing wind energy using neural networks",
    gesetzte_schwerpunkte: "Optimization, Sustainability, Technology",
    anmeldung_pruefungsamt: Date.new(2024, 4, 1),
    abgabedatum: Date.new(2024, 9, 1),
    studienniveau: "master",
    student_id: 3,
    projekt_id: 1
  },
  {
    betreuer: "Dr. Weber",
    forschungsprojekt: "Blockchain in Supply Chain Management",
    semester: "Winter 2023",
    matrikelnummer: "123456",
    angepasste_themenskizze: "Leveraging blockchain for traceability",
    gesetzte_schwerpunkte: "Blockchain, Logistics, Security",
    anmeldung_pruefungsamt: Date.new(2023, 10, 15),
    abgabedatum: Date.new(2024, 3, 15),
    studienniveau: "bachelor",
    student_id: 2,
    projekt_id: 1
  },
  {
    betreuer: "Prof. Fischer",
    forschungsprojekt: "Climate Change Modeling",
    semester: "Summer 2023",
    matrikelnummer: "7947810",
    angepasste_themenskizze: "Predicting climate patterns using AI",
    gesetzte_schwerpunkte: "Climate Modeling, Big Data, AI",
    anmeldung_pruefungsamt: Date.new(2023, 5, 1),
    abgabedatum: Date.new(2023, 10, 1),
    studienniveau: "bachelor",
    student_id: 1,
    projekt_id: 1
  },
  {
    betreuer: "Prof. Müller",
    forschungsprojekt: "Renewable Energy Optimization",
    semester: "Summer 2024",
    matrikelnummer: "789123",
    angepasste_themenskizze: "Optimizing wind energy using neural networks",
    gesetzte_schwerpunkte: "Optimization, Sustainability, Technology",
    anmeldung_pruefungsamt: Date.new(2024, 4, 1),
    abgabedatum: Date.new(2024, 9, 1),
    studienniveau: "master",
    student_id: 6,
    projekt_id: 1
  },
  {
    betreuer: "Dr. Weber",
    forschungsprojekt: "Blockchain in Supply Chain Management",
    semester: "Winter 2023",
    matrikelnummer: "987654",
    angepasste_themenskizze: "Leveraging blockchain for traceability",
    gesetzte_schwerpunkte: "Blockchain, Logistics, Security",
    anmeldung_pruefungsamt: Date.new(2023, 10, 15),
    abgabedatum: Date.new(2024, 3, 15),
    studienniveau: "bachelor",
    student_id: 7,
    projekt_id: 1
  },
  {
    betreuer: "Prof. Fischer",
    forschungsprojekt: "Climate Change Modeling",
    semester: "Summer 2023",
    matrikelnummer: "321987",
    angepasste_themenskizze: "Predicting climate patterns using AI",
    gesetzte_schwerpunkte: "Climate Modeling, Big Data, AI",
    anmeldung_pruefungsamt: Date.new(2023, 5, 1),
    abgabedatum: Date.new(2023, 10, 1),
    studienniveau: "master",
    student_id: 8,
    projekt_id: 1
  },
  {
    betreuer: "Dr. Meyer",
    forschungsprojekt: "Quantum Computing Applications",
    semester: "Winter 2024",
    matrikelnummer: "458721",
    angepasste_themenskizze: "Exploring quantum algorithms for cryptography",
    gesetzte_schwerpunkte: "Quantum Computing, Cryptography, Algorithms",
    anmeldung_pruefungsamt: Date.new(2024, 2, 10),
    abgabedatum: Date.new(2024, 7, 10),
    studienniveau: "bachelor",
    student_id: 9,
    projekt_id: 2
  },
  {
    betreuer: "Prof. Braun",
    forschungsprojekt: "Autonomous Vehicles",
    semester: "Summer 2024",
    matrikelnummer: "102348",
    angepasste_themenskizze: "Designing robust pathfinding algorithms",
    gesetzte_schwerpunkte: "Autonomy, Safety, Optimization",
    anmeldung_pruefungsamt: Date.new(2024, 3, 20),
    abgabedatum: Date.new(2024, 8, 20),
    studienniveau: "master",
    student_id: 10,
    projekt_id: 2
  },
  {
    betreuer: "Dr. Becker",
    forschungsprojekt: "Robotics in Medicine",
    semester: "Winter 2023",
    matrikelnummer: "847263",
    angepasste_themenskizze: "Development of robotic surgery systems",
    gesetzte_schwerpunkte: "Robotics, Surgery, Automation",
    anmeldung_pruefungsamt: Date.new(2023, 12, 1),
    abgabedatum: Date.new(2024, 5, 1),
    studienniveau: "bachelor",
    student_id: 11,
    projekt_id: 2
  },
  {
    betreuer: "Prof. Schneider",
    forschungsprojekt: "Space Exploration",
    semester: "Summer 2023",
    matrikelnummer: "394857",
    angepasste_themenskizze: "Building AI for interplanetary navigation",
    gesetzte_schwerpunkte: "Space, Navigation, AI",
    anmeldung_pruefungsamt: Date.new(2023, 6, 15),
    abgabedatum: Date.new(2023, 11, 15),
    studienniveau: "master",
    student_id: 12,
    projekt_id: 2
  }
])

