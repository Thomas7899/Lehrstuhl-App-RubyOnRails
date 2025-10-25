# This file ensures the existence of records required to run the application in every environment
# It can be executed safely multiple times (idempotent).

puts "🌱 Seeding database..."

# --- User Seeding ---
User.find_or_create_by!(email_address: "admin@example.de") do |user|
  user.password = "password"
  puts "-> Created or found admin user."
end

# --- Student Seeding ---
puts "--> Seeding students..."
students_data = [
  ["thomas@web.de", "7947810", "Thomas", "Osterlehner", DateTime.new(1990, 5, 2)],
  ["sabine@web.de", "123456", "Sabine", "Musterfrau", DateTime.new(2000, 9, 14)],
  ["sascha@web.de", "122456", "Sascha", "Mustermann", DateTime.new(1999, 5, 12)],
  ["max.mueller@example.com", "654321", "Max", "Müller", DateTime.new(2000, 3, 15)],
  ["lena.meier@example.com", "789123", "Lena", "Meier", DateTime.new(1998, 12, 5)],
  ["paul.bauer@example.com", "987654", "Paul", "Bauer", DateTime.new(1997, 7, 18)],
  ["anna.fischer@example.com", "321987", "Anna", "Fischer", DateTime.new(2002, 1, 30)],
  ["benjamin.keller@example.com", "458721", "Benjamin", "Keller", DateTime.new(2000, 11, 22)],
  ["sophie.huber@example.com", "102348", "Sophie", "Huber", DateTime.new(1999, 4, 17)],
  ["lucas.braun@example.com", "847263", "Lucas", "Braun", DateTime.new(2001, 6, 9)]
]

students_data.each do |email, matrikelnummer, vorname, nachname, geburtsdatum|
  Student.find_or_create_by!(matrikelnummer: matrikelnummer) do |student|
    student.email = email
    student.vorname = vorname
    student.nachname = nachname
    student.geburtsdatum = geburtsdatum
  end
end
puts "-> #{Student.count} students are now in the database."

# --- Abstract Thesis Seeding ---
puts "--> Seeding abstract theses..."

abstracts_data = [
  {
    thema: "Exploring the use of AI for diagnostics",
    betreuer: "Dr. Schmidt",
    forschungsprojekt: "AI in Healthcare",
    semester: "Winter 2024",
    themenskizze: "Machine Learning, Ethics, Data Privacy"
  },
  {
    thema: "Using blockchain to secure patient data",
    betreuer: "Prof. Müller",
    forschungsprojekt: "Blockchain in Healthcare",
    semester: "Summer 2024",
    themenskizze: "Blockchain, Security, Data Privacy"
  },
  {
    thema: "Health monitoring using smartwatches and AI",
    betreuer: "Dr. Fischer",
    forschungsprojekt: "Wearable Health Devices",
    semester: "Winter 2024",
    themenskizze: "Wearables, Data Analysis, Health Tracking"
  },
  {
    thema: "Ethical challenges of AI in medical decision-making",
    betreuer: "Dr. Weber",
    forschungsprojekt: "Ethics of Artificial Intelligence",
    semester: "Winter 2024",
    themenskizze: "Ethics, Medicine, AI"
  },
  {
    thema: "AI-assisted robotic surgery systems",
    betreuer: "Dr. Wagner",
    forschungsprojekt: "Robotics in Surgery",
    semester: "Summer 2023",
    themenskizze: "Robotics, Surgery, Machine Learning"
  }
]

abstracts_data.each_with_index do |data, index|
  AbstrakteAbschlussarbeit.find_or_create_by!(thema: data[:thema]) do |arbeit|
    arbeit.betreuer = data[:betreuer]
    arbeit.forschungsprojekt = data[:forschungsprojekt]
    arbeit.semester = data[:semester]
    arbeit.themenskizze = data[:themenskizze]
    arbeit.projekt_id = index + 1
  end
end

puts "-> #{AbstrakteAbschlussarbeit.count} abstract theses are now in the database."

# --- Concrete Thesis Seeding ---
puts "--> Seeding concrete theses..."

konkrete_arbeiten_data = [
  {
    matrikelnummer: "654321",
    betreuer: "Dr. Schmidt",
    forschungsprojekt: "AI in Healthcare",
    semester: "Winter 2024",
    angepasste_themenskizze: "Exploring the use of AI for diagnostics",
    gesetzte_schwerpunkte: "Machine Learning, Ethics, Data Privacy",
    anmeldung_pruefungsamt: Date.new(2024, 1, 15),
    abgabedatum: Date.new(2024, 6, 15),
    studienniveau: "bachelor",
    projekt_id: 1
  },
  {
    matrikelnummer: "122456",
    betreuer: "Prof. Müller",
    forschungsprojekt: "Blockchain in Healthcare",
    semester: "Summer 2024",
    angepasste_themenskizze: "Securing patient data using blockchain technology",
    gesetzte_schwerpunkte: "Blockchain, Security, Healthcare IT",
    anmeldung_pruefungsamt: Date.new(2024, 4, 1),
    abgabedatum: Date.new(2024, 9, 1),
    studienniveau: "master",
    projekt_id: 2
  },
  {
    matrikelnummer: "789123",
    betreuer: "Dr. Fischer",
    forschungsprojekt: "Wearable Health Devices",
    semester: "Winter 2024",
    angepasste_themenskizze: "Analyzing smartwatch data for early disease detection",
    gesetzte_schwerpunkte: "Wearables, Data Science, Health Monitoring",
    anmeldung_pruefungsamt: Date.new(2024, 2, 10),
    abgabedatum: Date.new(2024, 7, 10),
    studienniveau: "bachelor",
    projekt_id: 3
  },
  {
    matrikelnummer: "987654",
    betreuer: "Dr. Weber",
    forschungsprojekt: "Ethics of Artificial Intelligence",
    semester: "Winter 2024",
    angepasste_themenskizze: "Ethical and legal implications of AI-based diagnostics",
    gesetzte_schwerpunkte: "Ethics, AI Regulation, Medical Responsibility",
    anmeldung_pruefungsamt: Date.new(2024, 3, 1),
    abgabedatum: Date.new(2024, 8, 1),
    studienniveau: "master",
    projekt_id: 4
  },
  {
    matrikelnummer: "321987",
    betreuer: "Dr. Wagner",
    forschungsprojekt: "Robotics in Surgery",
    semester: "Summer 2023",
    angepasste_themenskizze: "AI-assisted robotic surgery optimization",
    gesetzte_schwerpunkte: "Robotics, Surgery, AI Optimization",
    anmeldung_pruefungsamt: Date.new(2023, 5, 10),
    abgabedatum: Date.new(2023, 10, 10),
    studienniveau: "bachelor",
    projekt_id: 5
  }
]

konkrete_arbeiten_data.each do |arbeit_data|
  student = Student.find_by(matrikelnummer: arbeit_data[:matrikelnummer])

  if student.nil?
    puts "⚠️  WARNING: Could not find student with matrikelnummer #{arbeit_data[:matrikelnummer]}. Skipping thesis."
    next
  end

  KonkreteAbschlussarbeit.find_or_create_by!(
    student: student,
    angepasste_themenskizze: arbeit_data[:angepasste_themenskizze]
  ) do |arbeit|
    arbeit.betreuer = arbeit_data[:betreuer]
    arbeit.forschungsprojekt = arbeit_data[:forschungsprojekt]
    arbeit.semester = arbeit_data[:semester]
    arbeit.matrikelnummer = arbeit_data[:matrikelnummer]
    arbeit.gesetzte_schwerpunkte = arbeit_data[:gesetzte_schwerpunkte]
    arbeit.anmeldung_pruefungsamt = arbeit_data[:anmeldung_pruefungsamt]
    arbeit.abgabedatum = arbeit_data[:abgabedatum]
    arbeit.studienniveau = arbeit_data[:studienniveau]
    arbeit.projekt_id = arbeit_data[:projekt_id]
  end
end

puts "-> #{KonkreteAbschlussarbeit.count} concrete theses are now in the database."

puts "✅ Seeding finished."
