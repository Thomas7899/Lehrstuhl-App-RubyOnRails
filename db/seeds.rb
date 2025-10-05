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

# Erweiterte Studierenden-Sammlung für realistisches Erlebnis
students_data = [
  # Computer Science / Informatik
  ["david.schneider@uni-example.de", "8001234", "David", "Schneider", DateTime.new(1999, 3, 15)],
  ["maria.gonzalez@uni-example.de", "8001235", "Maria", "González", DateTime.new(2000, 8, 22)],
  ["tobias.mueller@uni-example.de", "8001236", "Tobias", "Müller", DateTime.new(1998, 11, 9)],
  ["sarah.brown@uni-example.de", "8001237", "Sarah", "Brown", DateTime.new(2001, 5, 3)],
  ["felix.wagner@uni-example.de", "8001238", "Felix", "Wagner", DateTime.new(1997, 12, 28)],
  
  # Wirtschaftsinformatik
  ["nina.zimmermann@uni-example.de", "8001239", "Nina", "Zimmermann", DateTime.new(2000, 2, 14)],
  ["kevin.peters@uni-example.de", "8001240", "Kevin", "Peters", DateTime.new(1999, 7, 11)],
  ["lisa.hoffman@uni-example.de", "8001241", "Lisa", "Hoffmann", DateTime.new(2001, 9, 6)],
  ["marco.richter@uni-example.de", "8001242", "Marco", "Richter", DateTime.new(1998, 4, 19)],
  ["elena.koch@uni-example.de", "8001243", "Elena", "Koch", DateTime.new(2000, 10, 12)],
  
  # Data Science
  ["jan.neumann@uni-example.de", "8001244", "Jan", "Neumann", DateTime.new(1997, 6, 25)],
  ["clara.schwarz@uni-example.de", "8001245", "Clara", "Schwarz", DateTime.new(2001, 1, 8)],
  ["daniel.klein@uni-example.de", "8001246", "Daniel", "Klein", DateTime.new(1999, 8, 17)],
  ["michelle.weiss@uni-example.de", "8001247", "Michelle", "Weiss", DateTime.new(2000, 3, 30)],
  ["simon.lang@uni-example.de", "8001248", "Simon", "Lang", DateTime.new(1998, 11, 14)],
  
  # Medieninformatik
  ["jessica.martin@uni-example.de", "8001249", "Jessica", "Martin", DateTime.new(2001, 4, 21)],
  ["phillip.gross@uni-example.de", "8001250", "Phillip", "Groß", DateTime.new(1999, 9, 4)],
  ["vanessa.lehmann@uni-example.de", "8001251", "Vanessa", "Lehmann", DateTime.new(2000, 12, 16)],
  ["noah.schmitt@uni-example.de", "8001252", "Noah", "Schmitt", DateTime.new(1997, 5, 23)],
  ["amelie.hartmann@uni-example.de", "8001253", "Amelie", "Hartmann", DateTime.new(2001, 8, 9)],
  
  # Internationale Studierende
  ["yuki.tanaka@uni-example.de", "8001254", "Yuki", "Tanaka", DateTime.new(2000, 2, 28)],
  ["priya.sharma@uni-example.de", "8001255", "Priya", "Sharma", DateTime.new(1999, 6, 12)],
  ["ahmed.hassan@uni-example.de", "8001256", "Ahmed", "Hassan", DateTime.new(1998, 10, 5)],
  ["anna.kowalski@uni-example.de", "8001257", "Anna", "Kowalski", DateTime.new(2001, 3, 18)],
  ["carlos.rodriguez@uni-example.de", "8001258", "Carlos", "Rodriguez", DateTime.new(2000, 7, 26)],
  
  # Master-Studierende
  ["dr.thomas.weber@uni-example.de", "9001259", "Thomas", "Weber", DateTime.new(1995, 1, 12)],
  ["laura.meyer@uni-example.de", "9001260", "Laura", "Meyer", DateTime.new(1996, 4, 8)],
  ["stefan.jung@uni-example.de", "9001261", "Stefan", "Jung", DateTime.new(1994, 9, 22)],
  ["christina.moeller@uni-example.de", "9001262", "Christina", "Möller", DateTime.new(1995, 11, 15)],
  ["michael.krause@uni-example.de", "9001263", "Michael", "Krause", DateTime.new(1993, 8, 3)],
  
  # PhD Candidates
  ["robert.schulz@uni-example.de", "9901264", "Robert", "Schulz", DateTime.new(1992, 5, 19)],
  ["sophia.werner@uni-example.de", "9901265", "Sophia", "Werner", DateTime.new(1991, 12, 7)],
  ["maximilian.beck@uni-example.de", "9901266", "Maximilian", "Beck", DateTime.new(1990, 3, 24)],
  ["julia.herrmann@uni-example.de", "9901267", "Julia", "Herrmann", DateTime.new(1993, 7, 11)],
  ["florian.sommer@uni-example.de", "9901268", "Florian", "Sommer", DateTime.new(1991, 10, 29)],
  
  # Praktikanten/Werkstudenten
  ["tim.vogel@uni-example.de", "7001269", "Tim", "Vogel", DateTime.new(2002, 1, 17)],
  ["leonie.winter@uni-example.de", "7001270", "Leonie", "Winter", DateTime.new(2003, 6, 4)],
  ["robin.fuchs@uni-example.de", "7001271", "Robin", "Fuchs", DateTime.new(2002, 9, 13)],
  ["maya.patel@uni-example.de", "7001272", "Maya", "Patel", DateTime.new(2003, 2, 26)],
  ["luis.fernandez@uni-example.de", "7001273", "Luis", "Fernández", DateTime.new(2002, 11, 8)]
]

# Batch-Erstellung der Studierenden
students_data.each do |email, matrikelnummer, vorname, nachname, geburtsdatum|
  Student.find_or_create_by!(matrikelnummer: matrikelnummer) do |student|
    student.email = email
    student.vorname = vorname
    student.nachname = nachname
    student.geburtsdatum = geburtsdatum
  end
end

puts "#{Student.count} Studierende in der Datenbank."

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

