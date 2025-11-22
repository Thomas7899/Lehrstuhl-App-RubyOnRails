# This file ensures the existence of records required to run the application in every environment
# It can be executed safely multiple times (idempotent).

# Helper to generate a random date within a range
def random_date(from = 25.years.ago, to = 18.years.ago)
  Time.at(rand(from.to_time.to_f..to.to_time.to_f)).to_date
end

puts "🌱 Seeding database..."

# --- User Seeding ---
User.find_or_create_by!(email_address: "admin@example.de") do |user|
  user.password = "password"
  puts "-> Created or found admin user."
end

# --- Student Seeding ---
puts "--> Seeding 50 students..."

# Keep original 10 students
Student.find_or_create_by!(matrikelnummer: "7947810") { |s| s.assign_attributes(email: "thomas@web.de", vorname: "Thomas", nachname: "Osterlehner", geburtsdatum: Date.new(1990, 5, 2)) }
Student.find_or_create_by!(matrikelnummer: "123456") { |s| s.assign_attributes(email: "sabine@web.de", vorname: "Sabine", nachname: "Musterfrau", geburtsdatum: Date.new(2000, 9, 14)) }
Student.find_or_create_by!(matrikelnummer: "122456") { |s| s.assign_attributes(email: "sascha@web.de", vorname: "Sascha", nachname: "Mustermann", geburtsdatum: Date.new(1999, 5, 12)) }
Student.find_or_create_by!(matrikelnummer: "654321") { |s| s.assign_attributes(email: "max.mueller@example.com", vorname: "Max", nachname: "Müller", geburtsdatum: Date.new(2000, 3, 15)) }
Student.find_or_create_by!(matrikelnummer: "789123") { |s| s.assign_attributes(email: "lena.meier@example.com", vorname: "Lena", nachname: "Meier", geburtsdatum: Date.new(1998, 12, 5)) }
Student.find_or_create_by!(matrikelnummer: "987654") { |s| s.assign_attributes(email: "paul.bauer@example.com", vorname: "Paul", nachname: "Bauer", geburtsdatum: Date.new(1997, 7, 18)) }
Student.find_or_create_by!(matrikelnummer: "321987") { |s| s.assign_attributes(email: "anna.fischer@example.com", vorname: "Anna", nachname: "Fischer", geburtsdatum: Date.new(2002, 1, 30)) }
Student.find_or_create_by!(matrikelnummer: "458721") { |s| s.assign_attributes(email: "benjamin.keller@example.com", vorname: "Benjamin", nachname: "Keller", geburtsdatum: Date.new(2000, 11, 22)) }
Student.find_or_create_by!(matrikelnummer: "102348") { |s| s.assign_attributes(email: "sophie.huber@example.com", vorname: "Sophie", nachname: "Huber", geburtsdatum: Date.new(1999, 4, 17)) }
Student.find_or_create_by!(matrikelnummer: "847263") { |s| s.assign_attributes(email: "lucas.braun@example.com", vorname: "Lucas", nachname: "Braun", geburtsdatum: Date.new(2001, 6, 9)) }

# Generate 40 more students
first_names = %w[Lukas Leon Finn Jonas Felix Elias Paul Noah Ben Luca]
last_names = %w[Schmidt Schneider Hoffmann Meyer Wolf Becker Klein Schröder]

# Generate more students only if there are fewer than 50
if Student.count < 50
  (50 - Student.count).times do
    vorname = first_names.sample
    nachname = last_names.sample
    matrikelnummer = (rand(900000) + 100000).to_s
    email = "#{vorname.downcase}.#{nachname.downcase}#{rand(100)}@example.com"
    geburtsdatum = random_date

    Student.find_or_create_by!(matrikelnummer: matrikelnummer) do |student|
      student.email = email
      student.vorname = vorname
      student.nachname = nachname
      student.geburtsdatum = geburtsdatum
    end
  end
end

puts "-> #{Student.count} students are now in the database."

# --- Abstract Thesis Seeding ---
puts "--> Seeding 20 abstract theses..."

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
  },
  {
    thema: "Predictive Analytics for Hospital Resource Management",
    betreuer: "Prof. Dr. Ziegler",
    forschungsprojekt: "AI in Healthcare",
    semester: "Winter 2023",
    themenskizze: "Predictive Modeling, Operations Research, Hospital Logistics"
  },
  {
    thema: "Decentralized Identity for Medical Records",
    betreuer: "Prof. Müller",
    forschungsprojekt: "Blockchain in Healthcare",
    semester: "Summer 2024",
    themenskizze: "DID, Verifiable Credentials, GDPR"
  },
  {
    thema: "Federated Learning for Privacy-Preserving Medical Imaging Analysis",
    betreuer: "Dr. Schmidt",
    forschungsprojekt: "AI in Healthcare",
    semester: "Winter 2024",
    themenskizze: "Federated Learning, Privacy, Medical Imaging"
  },
  {
    thema: "Gamification in Mobile Health Applications",
    betreuer: "Dr. Fischer",
    forschungsprojekt: "Wearable Health Devices",
    semester: "Summer 2023",
    themenskizze: "Gamification, mHealth, User Engagement"
  }
]

abstracts_data.each_with_index do |data, index|
  AbstrakteAbschlussarbeit.find_or_create_by!(
    thema: data[:thema],
    forschungsprojekt: data[:forschungsprojekt]
  ) do |arbeit|
    arbeit.betreuer = data[:betreuer]
    arbeit.semester = data[:semester]
    arbeit.themenskizze = data[:themenskizze]
    arbeit.projekt_id = index + 1
  end
end

puts "-> #{AbstrakteAbschlussarbeit.count} abstract theses are now in the database (added/found #{abstracts_data.size})."


# --- Concrete Thesis Seeding ---
puts "--> Seeding 15 concrete theses..."

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
  },
  {
    matrikelnummer: "102348", # Sophie Huber
    betreuer: "Dr. Schmidt",
    forschungsprojekt: "AI in Healthcare",
    semester: "Winter 2023",
    angepasste_themenskizze: "Federated Learning on Chest X-Rays",
    gesetzte_schwerpunkte: "Federated Learning, CNNs, X-Ray",
    anmeldung_pruefungsamt: Date.new(2023, 10, 1),
    abgabedatum: Date.new(2024, 3, 1),
    studienniveau: "master",
    projekt_id: 8
  },
  {
    matrikelnummer: "847263", # Lucas Braun
    betreuer: "Dr. Fischer",
    forschungsprojekt: "Wearable Health Devices",
    semester: "Summer 2023",
    angepasste_themenskizze: "Gamified approach to increase physical activity using smartwatches",
    gesetzte_schwerpunkte: "Gamification, Wearables, Health Promotion",
    anmeldung_pruefungsamt: Date.new(2023, 4, 15),
    abgabedatum: Date.new(2023, 9, 15),
    studienniveau: "bachelor",
    projekt_id: 9
  }
]

# Add more concrete theses for random students if there are fewer than 15
if KonkreteAbschlussarbeit.count < 15
  needed = 15 - KonkreteAbschlussarbeit.count
  available_students = Student.where.not(matrikelnummer: KonkreteAbschlussarbeit.pluck(:matrikelnummer)).order("RANDOM()").limit(needed)
  available_abstracts = AbstrakteAbschlussarbeit.order("RANDOM()").limit(needed)

  available_students.zip(available_abstracts).each do |student, abstract_thesis|
    next unless student && abstract_thesis
    konkrete_arbeiten_data << {
      matrikelnummer: student.matrikelnummer,
      betreuer: abstract_thesis.betreuer,
      forschungsprojekt: abstract_thesis.forschungsprojekt,
      semester: ["WiSe 23/24", "SoSe 24", "WiSe 24/25"].sample,
      angepasste_themenskizze: "Individuelle Ausarbeitung zu: #{abstract_thesis.thema}",
      gesetzte_schwerpunkte: abstract_thesis.themenskizze,
      anmeldung_pruefungsamt: random_date(1.year.ago, 6.months.ago),
      abgabedatum: random_date(5.months.ago, Date.today),
      studienniveau: ["bachelor", "master"].sample,
      projekt_id: abstract_thesis.projekt_id
    }
  end
end

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

# --- Mitarbeiter Seeding ---
puts "--> Seeding 10 mitarbeiter..."
mitarbeiter_data = [
  { vorname: "Peter", nachname: "Klaus", email: "peter.klaus@uni.de", titel: "Prof. Dr." },
  { vorname: "Angelika", nachname: "Schwarz", email: "angelika.schwarz@uni.de", titel: "Dr." },
  { vorname: "Jonas", nachname: "Weiss", email: "jonas.weiss@uni.de", titel: "Prof. Dr." },
  { vorname: "Sabine", nachname: "Lang", email: "sabine.lang@uni.de", titel: "Dr." },
  { vorname: "Markus", nachname: "Bauer", email: "markus.bauer@uni.de", titel: "Dr." },
  { vorname: "Julia", nachname: "Keller", email: "julia.keller@uni.de", titel: "M.Sc." },
  { vorname: "Florian", nachname: "Vogel", email: "florian.vogel@uni.de", titel: "M.Sc." },
  { vorname: "Laura", nachname: "Zimmermann", email: "laura.zimmermann@uni.de", titel: "Prof. Dr." },
  { vorname: "Michael", nachname: "Hartmann", email: "michael.hartmann@uni.de", titel: "Dr." },
  { vorname: "Stefanie", nachname: "Richter", email: "stefanie.richter@uni.de", titel: "M.Sc." }
]

mitarbeiter_data.each do |data|
  Mitarbeiter.find_or_create_by!(email: data[:email]) do |m|
    m.vorname = data[:vorname]
    m.nachname = data[:nachname]
    m.titel = data[:titel]
  end
end
puts "-> #{Mitarbeiter.count} mitarbeiter are now in the database."

# --- Abstrakte Seminare Seeding ---
puts "--> Seeding 5 abstrakte seminare..."
peter_klaus = Mitarbeiter.find_by!(email: "peter.klaus@uni.de")
angelika_schwarz = Mitarbeiter.find_by!(email: "angelika.schwarz@uni.de")
sabine_lang = Mitarbeiter.find_by!(email: "sabine.lang@uni.de")
laura_zimmermann = Mitarbeiter.find_by!(email: "laura.zimmermann@uni.de")

abstrakte_seminare_data = [
  { thema: "Grundlagen der künstlichen Intelligenz", beschreibung: "Eine Einführung in die Kernkonzepte von KI und maschinellem Lernen.", mitarbeiter: peter_klaus },
  { thema: "Moderne Web-Technologien", beschreibung: "Ein Überblick über aktuelle Frameworks und Architekturen im Web-Development.", mitarbeiter: angelika_schwarz },
  { thema: "Datenbanksysteme für Big Data", beschreibung: "Vergleich und Anwendung von SQL- und NoSQL-Datenbanken.", mitarbeiter: peter_klaus },
  { thema: "IT-Sicherheit in der Praxis", beschreibung: "Analyse von Sicherheitslücken und Entwicklung von Schutzmaßnahmen.", mitarbeiter: sabine_lang },
  { thema: "Ethik in der Informatik", beschreibung: "Diskussion ethischer Fragestellungen im Kontext der Digitalisierung.", mitarbeiter: laura_zimmermann }
]

abstrakte_seminare_data.each do |data|
  AbstraktesSeminar.find_or_create_by!(thema: data[:thema]) do |as|
    as.beschreibung = data[:beschreibung]
    as.mitarbeiter = data[:mitarbeiter]
  end
end
puts "-> #{AbstraktesSeminar.count} abstrakte seminare are now in the database."

# --- Konkrete Seminare Seeding ---
puts "--> Seeding 8 seminare..."
ai_seminar_abstrakt = AbstraktesSeminar.find_by!(thema: "Grundlagen der künstlichen Intelligenz")
web_seminar_abstrakt = AbstraktesSeminar.find_by!(thema: "Moderne Web-Technologien")
db_seminar_abstrakt = AbstraktesSeminar.find_by!(thema: "Datenbanksysteme für Big Data")
itsec_seminar_abstrakt = AbstraktesSeminar.find_by!(thema: "IT-Sicherheit in der Praxis")

seminare_data = [
  { titel: "KI-Grundlagen", aufnahmekapazitaet: 20, semester: "WiSe 24/25", praesenzdatum: Date.new(2024, 11, 5), ort: "Raum A101", abstraktes_seminar: ai_seminar_abstrakt, mitarbeiter: ai_seminar_abstrakt.mitarbeiter },
  { titel: "Web-Dev Pro", aufnahmekapazitaet: 15, semester: "WiSe 24/25", praesenzdatum: Date.new(2024, 11, 7), ort: "Raum B203", abstraktes_seminar: web_seminar_abstrakt, mitarbeiter: web_seminar_abstrakt.mitarbeiter },
  { titel: "KI-Grundlagen", aufnahmekapazitaet: 20, semester: "SoSe 25", praesenzdatum: Date.new(2025, 4, 15), ort: "Raum A101", abstraktes_seminar: ai_seminar_abstrakt, mitarbeiter: ai_seminar_abstrakt.mitarbeiter },
  { titel: "Big Data Engineering", aufnahmekapazitaet: 18, semester: "WiSe 24/25", praesenzdatum: Date.new(2024, 10, 22), ort: "Raum C110", abstraktes_seminar: db_seminar_abstrakt, mitarbeiter: db_seminar_abstrakt.mitarbeiter },
  { titel: "Hacking & Defense", aufnahmekapazitaet: 25, semester: "SoSe 24", praesenzdatum: Date.new(2024, 5, 14), ort: "Raum D007", abstraktes_seminar: itsec_seminar_abstrakt, mitarbeiter: itsec_seminar_abstrakt.mitarbeiter },
  { titel: "Web-Dev Pro", aufnahmekapazitaet: 15, semester: "SoSe 25", praesenzdatum: Date.new(2025, 4, 17), ort: "Raum B203", abstraktes_seminar: web_seminar_abstrakt, mitarbeiter: web_seminar_abstrakt.mitarbeiter },
  { titel: "KI-Grundlagen", aufnahmekapazitaet: 20, semester: "WiSe 23/24", praesenzdatum: Date.new(2023, 11, 6), ort: "Raum A101", abstraktes_seminar: ai_seminar_abstrakt, mitarbeiter: ai_seminar_abstrakt.mitarbeiter },
  { titel: "Hacking & Defense", aufnahmekapazitaet: 25, semester: "WiSe 24/25", praesenzdatum: Date.new(2024, 11, 12), ort: "Raum D007", abstraktes_seminar: itsec_seminar_abstrakt, mitarbeiter: itsec_seminar_abstrakt.mitarbeiter }
]

seminare_data.each do |data|
  Seminar.find_or_create_by!(titel: data[:titel], semester: data[:semester]) do |s|
    s.aufnahmekapazitaet = data[:aufnahmekapazitaet]
    s.praesenzdatum = data[:praesenzdatum]
    s.ort = data[:ort]
    s.abstraktes_seminar = data[:abstraktes_seminar]
    s.mitarbeiter = data[:mitarbeiter]
  end
end
puts "-> #{Seminar.count} seminare are now in the database."

# --- Klausuren Seeding ---
puts "--> Seeding 6 klausuren..."
klausuren_data = [
  { titel: "Einführung in die Informatik I", modul: "CS101", semester: "WiSe 24/25" },
  { titel: "Datenbanken", modul: "CS305", semester: "WiSe 24/25" },
  { titel: "Software Engineering", modul: "CS401", semester: "SoSe 25" },
  { titel: "Algorithmen und Datenstrukturen", modul: "CS201", semester: "SoSe 24" },
  { titel: "Rechnernetze", modul: "CS501", semester: "WiSe 24/25" },
  { titel: "Theoretische Informatik", modul: "CS301", semester: "SoSe 25" }
]

klausuren_data.each do |data|
  Klausur.find_or_create_by!(titel: data[:titel], semester: data[:semester]) do |k|
    k.modul = data[:modul]
  end
end
puts "-> #{Klausur.count} klausuren are now in the database."

# --- Ergebnisse Seeding ---
puts "--> Seeding seminar- und klausurergebnisse..."

# Seminarergebnisse für bis zu 30 zufällige Studenten in verschiedenen Seminaren
if Seminarergebnis.count < 30
  needed = 30 - Seminarergebnis.count
  studenten_sample_seminar = Student.order("RANDOM()").limit(needed)
  seminare_sample = Seminar.all

  studenten_sample_seminar.each do |student|
    seminar = seminare_sample.sample
    Seminarergebnis.find_or_create_by!(student: student, seminar: seminar) do |se|
      se.muendlich_note = [1.0, 1.3, 1.7, 2.0, 2.3, 2.7, 3.0, 3.3, 3.7, 4.0, 5.0].sample.round(1)
      se.schriftlich_note = [1.0, 1.3, 1.7, 2.0, 2.3, 2.7, 3.0, 3.3, 3.7, 4.0, 5.0].sample.round(1)
      se.gesamt = ((se.muendlich_note + se.schriftlich_note) / 2).round(1)
      se.versuche = rand(1..2)
    end
  end
end

# Klausurergebnisse für bis zu 40 zufällige Studenten in verschiedenen Klausuren
if Klausurergebnis.count < 40
  needed = 40 - Klausurergebnis.count
  studenten_sample_klausur = Student.order("RANDOM()").limit(needed)
  klausuren_sample = Klausur.all

  studenten_sample_klausur.each do |student|
    klausur_db = klausuren_sample.sample
    if klausur_db
      Klausurergebnis.find_or_create_by!(student: student, klausur: klausur_db) do |ke|
        ke.punkte = rand(50..100)
        ke.note = case ke.punkte
                  when 90..100 then 1.0
                  when 80..89 then 1.7
                  when 70..79 then 2.3
                  when 60..69 then 3.0
                  when 50..59 then 4.0
                  else 5.0
                  end
        ke.status = ke.note <= 4.0 ? "Bestanden" : "Nicht bestanden"
        ke.pruefungsdatum = random_date(1.year.ago, Date.today)
        ke.versuche = 1
      end
    end
  end
end

puts "-> #{Seminarergebnis.count} seminarergebnisse are now in the database."
puts "-> #{Klausurergebnis.count} klausurergebnisse are now in the database."

puts "✅ Seeding finished."
