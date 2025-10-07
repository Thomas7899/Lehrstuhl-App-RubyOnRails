# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Seeding database..."

# --- User Seeding ---
User.find_or_create_by!(email_address: "admin@example.de") do |user|
  user.password = "password"
  puts "-> Created or found admin user."
end

# --- Student Seeding ---
puts "--> Seeding students..."
students_data = [
  # Original students
  ["thomas@web.de", "7947810", "Thomas", "Osterlehner", DateTime.new(1990, 5, 2)],
  ["sabine@web.de", "123456", "Sabine", "Musterfrau", DateTime.new(2000, 9, 14)],
  ["sascha@web.de", "122456", "Sascha", "Mustermann", DateTime.new(1999, 5, 12)],
  ["julia.schmidt@example.com", "1234567", "Julia", "Schmidt", DateTime.new(2001, 8, 24)], # NOTE: Corrected duplicate matrikelnummer
  ["max.mueller@example.com", "654321", "Max", "Müller", DateTime.new(2000, 3, 15)],
  ["lena.meier@example.com", "789123", "Lena", "Meier", DateTime.new(1998, 12, 5)],
  ["paul.bauer@example.com", "987654", "Paul", "Bauer", DateTime.new(1997, 7, 18)],
  ["anna.fischer@example.com", "321987", "Anna", "Fischer", DateTime.new(2002, 1, 30)],
  ["benjamin.keller@example.com", "458721", "Benjamin", "Keller", DateTime.new(2000, 11, 22)],
  ["sophie.huber@example.com", "102348", "Sophie", "Huber", DateTime.new(1999, 4, 17)],
  ["lucas.braun@example.com", "847263", "Lucas", "Braun", DateTime.new(2001, 6, 9)],
  ["emma.vogel@example.com", "394857", "Emma", "Vogel", DateTime.new(1998, 10, 25)],
  ["leo.mayer@example.com", "574839", "Leo", "Mayer", DateTime.new(1997, 8, 14)],
  ["mia.schneider@example.com", "756293", "Mia", "Schneider", DateTime.new(2002, 3, 11)],
  ["jonas.bauer@example.com", "192837", "Jonas", "Bauer", DateTime.new(2000, 12, 29)],
  ["lara.fischer@example.com", "384759", "Lara", "Fischer", DateTime.new(1999, 9, 2)],
  ["alexander.wolf@example.com", "918273", "Alexander", "Wolf", DateTime.new(2001, 1, 15)],
  ["amelie.becker@example.com", "564738", "Amelie", "Becker", DateTime.new(1996, 7, 4)],
  # Extended students
  ["david.schneider@uni-example.de", "8001234", "David", "Schneider", DateTime.new(1999, 3, 15)],
  ["maria.gonzalez@uni-example.de", "8001235", "Maria", "González", DateTime.new(2000, 8, 22)],
  ["tobias.mueller@uni-example.de", "8001236", "Tobias", "Müller", DateTime.new(1998, 11, 9)],
  ["sarah.brown@uni-example.de", "8001237", "Sarah", "Brown", DateTime.new(2001, 5, 3)],
  ["felix.wagner@uni-example.de", "8001238", "Felix", "Wagner", DateTime.new(1997, 12, 28)],
  ["nina.zimmermann@uni-example.de", "8001239", "Nina", "Zimmermann", DateTime.new(2000, 2, 14)],
  ["kevin.peters@uni-example.de", "8001240", "Kevin", "Peters", DateTime.new(1999, 7, 11)],
  ["lisa.hoffman@uni-example.de", "8001241", "Lisa", "Hoffmann", DateTime.new(2001, 9, 6)],
  ["marco.richter@uni-example.de", "8001242", "Marco", "Richter", DateTime.new(1998, 4, 19)],
  ["elena.koch@uni-example.de", "8001243", "Elena", "Koch", DateTime.new(2000, 10, 12)],
  ["jan.neumann@uni-example.de", "8001244", "Jan", "Neumann", DateTime.new(1997, 6, 25)],
  ["clara.schwarz@uni-example.de", "8001245", "Clara", "Schwarz", DateTime.new(2001, 1, 8)],
  ["daniel.klein@uni-example.de", "8001246", "Daniel", "Klein", DateTime.new(1999, 8, 17)],
  ["michelle.weiss@uni-example.de", "8001247", "Michelle", "Weiss", DateTime.new(2000, 3, 30)],
  ["simon.lang@uni-example.de", "8001248", "Simon", "Lang", DateTime.new(1998, 11, 14)],
  ["jessica.martin@uni-example.de", "8001249", "Jessica", "Martin", DateTime.new(2001, 4, 21)],
  ["phillip.gross@uni-example.de", "8001250", "Phillip", "Groß", DateTime.new(1999, 9, 4)],
  ["vanessa.lehmann@uni-example.de", "8001251", "Vanessa", "Lehmann", DateTime.new(2000, 12, 16)],
  ["noah.schmitt@uni-example.de", "8001252", "Noah", "Schmitt", DateTime.new(1997, 5, 23)],
  ["amelie.hartmann@uni-example.de", "8001253", "Amelie", "Hartmann", DateTime.new(2001, 8, 9)],
  ["yuki.tanaka@uni-example.de", "8001254", "Yuki", "Tanaka", DateTime.new(2000, 2, 28)],
  ["priya.sharma@uni-example.de", "8001255", "Priya", "Sharma", DateTime.new(1999, 6, 12)],
  ["ahmed.hassan@uni-example.de", "8001256", "Ahmed", "Hassan", DateTime.new(1998, 10, 5)],
  ["anna.kowalski@uni-example.de", "8001257", "Anna", "Kowalski", DateTime.new(2001, 3, 18)],
  ["carlos.rodriguez@uni-example.de", "8001258", "Carlos", "Rodriguez", DateTime.new(2000, 7, 26)],
  ["dr.thomas.weber@uni-example.de", "9001259", "Thomas", "Weber", DateTime.new(1995, 1, 12)],
  ["laura.meyer@uni-example.de", "9001260", "Laura", "Meyer", DateTime.new(1996, 4, 8)],
  ["stefan.jung@uni-example.de", "9001261", "Stefan", "Jung", DateTime.new(1994, 9, 22)],
  ["christina.moeller@uni-example.de", "9001262", "Christina", "Möller", DateTime.new(1995, 11, 15)],
  ["michael.krause@uni-example.de", "9001263", "Michael", "Krause", DateTime.new(1993, 8, 3)],
  ["robert.schulz@uni-example.de", "9901264", "Robert", "Schulz", DateTime.new(1992, 5, 19)],
  ["sophia.werner@uni-example.de", "9901265", "Sophia", "Werner", DateTime.new(1991, 12, 7)],
  ["maximilian.beck@uni-example.de", "9901266", "Maximilian", "Beck", DateTime.new(1990, 3, 24)],
  ["julia.herrmann@uni-example.de", "9901267", "Julia", "Herrmann", DateTime.new(1993, 7, 11)],
  ["florian.sommer@uni-example.de", "9901268", "Florian", "Sommer", DateTime.new(1991, 10, 29)],
  ["tim.vogel@uni-example.de", "7001269", "Tim", "Vogel", DateTime.new(2002, 1, 17)],
  ["leonie.winter@uni-example.de", "7001270", "Leonie", "Winter", DateTime.new(2003, 6, 4)],
  ["robin.fuchs@uni-example.de", "7001271", "Robin", "Fuchs", DateTime.new(2002, 9, 13)],
  ["maya.patel@uni-example.de", "7001272", "Maya", "Patel", DateTime.new(2003, 2, 26)],
  ["luis.fernandez@uni-example.de", "7001273", "Luis", "Fernández", DateTime.new(2002, 11, 8)]
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
AbstrakteAbschlussarbeit.find_or_create_by!(projekt_id: 1) do |arbeit|
  arbeit.betreuer = "Dr. Schmidt"
  arbeit.forschungsprojekt = "AI in Healthcare"
  arbeit.semester = "Winter 2024"
  arbeit.thema = "Exploring the use of AI for diagnostics"
  arbeit.themenskizze = "Machine Learning, Ethics, Data Privacy"
end

AbstrakteAbschlussarbeit.find_or_create_by!(projekt_id: 2) do |arbeit|
  arbeit.betreuer = "Dr. Meyer"
  arbeit.forschungsprojekt = "Quantum Computing Applications"
  arbeit.semester = "Winter 2024"
  arbeit.thema = "Exploring quantum algorithms for cryptography"
  arbeit.themenskizze = "Quantum Computing, Cryptography, Algorithms"
end
puts "-> #{AbstrakteAbschlussarbeit.count} abstract theses are now in the database."

# --- Concrete Thesis Seeding ---
puts "--> Seeding concrete theses..."
konkrete_arbeiten_data = [
  { matrikelnummer: "654321", betreuer: "Dr. Schmidt", forschungsprojekt: "AI in Healthcare", semester: "Winter 2024", angepasste_themenskizze: "Exploring the use of AI for diagnostics", gesetzte_schwerpunkte: "Machine Learning, Ethics, Data Privacy", anmeldung_pruefungsamt: Date.new(2024, 1, 15), abgabedatum: Date.new(2024, 6, 15), studienniveau: "bachelor", projekt_id: 1 },
  { matrikelnummer: "122456", betreuer: "Prof. Müller", forschungsprojekt: "Renewable Energy Optimization", semester: "Summer 2024", angepasste_themenskizze: "Optimizing wind energy using neural networks", gesetzte_schwerpunkte: "Optimization, Sustainability, Technology", anmeldung_pruefungsamt: Date.new(2024, 4, 1), abgabedatum: Date.new(2024, 9, 1), studienniveau: "master", projekt_id: 1 },
  { matrikelnummer: "123456", betreuer: "Dr. Weber", forschungsprojekt: "Blockchain in Supply Chain Management", semester: "Winter 2023", angepasste_themenskizze: "Leveraging blockchain for traceability", gesetzte_schwerpunkte: "Blockchain, Logistics, Security", anmeldung_pruefungsamt: Date.new(2023, 10, 15), abgabedatum: Date.new(2024, 3, 15), studienniveau: "bachelor", projekt_id: 1 },
  { matrikelnummer: "7947810", betreuer: "Prof. Fischer", forschungsprojekt: "Climate Change Modeling", semester: "Summer 2023", angepasste_themenskizze: "Predicting climate patterns using AI", gesetzte_schwerpunkte: "Climate Modeling, Big Data, AI", anmeldung_pruefungsamt: Date.new(2023, 5, 1), abgabedatum: Date.new(2023, 10, 1), studienniveau: "bachelor", projekt_id: 1 },
  { matrikelnummer: "789123", betreuer: "Prof. Müller", forschungsprojekt: "Renewable Energy Optimization", semester: "Summer 2024", angepasste_themenskizze: "Optimizing wind energy using neural networks", gesetzte_schwerpunkte: "Optimization, Sustainability, Technology", anmeldung_pruefungsamt: Date.new(2024, 4, 1), abgabedatum: Date.new(2024, 9, 1), studienniveau: "master", projekt_id: 1 },
  { matrikelnummer: "987654", betreuer: "Dr. Weber", forschungsprojekt: "Blockchain in Supply Chain Management", semester: "Winter 2023", angepasste_themenskizze: "Leveraging blockchain for traceability", gesetzte_schwerpunkte: "Blockchain, Logistics, Security", anmeldung_pruefungsamt: Date.new(2023, 10, 15), abgabedatum: Date.new(2024, 3, 15), studienniveau: "bachelor", projekt_id: 1 },
  { matrikelnummer: "321987", betreuer: "Prof. Fischer", forschungsprojekt: "Climate Change Modeling", semester: "Summer 2023", angepasste_themenskizze: "Predicting climate patterns using AI", gesetzte_schwerpunkte: "Climate Modeling, Big Data, AI", anmeldung_pruefungsamt: Date.new(2023, 5, 1), abgabedatum: Date.new(2023, 10, 1), studienniveau: "master", projekt_id: 1 },
  { matrikelnummer: "458721", betreuer: "Dr. Meyer", forschungsprojekt: "Quantum Computing Applications", semester: "Winter 2024", angepasste_themenskizze: "Exploring quantum algorithms for cryptography", gesetzte_schwerpunkte: "Quantum Computing, Cryptography, Algorithms", anmeldung_pruefungsamt: Date.new(2024, 2, 10), abgabedatum: Date.new(2024, 7, 10), studienniveau: "bachelor", projekt_id: 2 },
  { matrikelnummer: "102348", betreuer: "Prof. Braun", forschungsprojekt: "Autonomous Vehicles", semester: "Summer 2024", angepasste_themenskizze: "Designing robust pathfinding algorithms", gesetzte_schwerpunkte: "Autonomy, Safety, Optimization", anmeldung_pruefungsamt: Date.new(2024, 3, 20), abgabedatum: Date.new(2024, 8, 20), studienniveau: "master", projekt_id: 2 },
  { matrikelnummer: "847263", betreuer: "Dr. Becker", forschungsprojekt: "Robotics in Medicine", semester: "Winter 2023", angepasste_themenskizze: "Development of robotic surgery systems", gesetzte_schwerpunkte: "Robotics, Surgery, Automation", anmeldung_pruefungsamt: Date.new(2023, 12, 1), abgabedatum: Date.new(2024, 5, 1), studienniveau: "bachelor", projekt_id: 2 },
  { matrikelnummer: "394857", betreuer: "Prof. Schneider", forschungsprojekt: "Space Exploration", semester: "Summer 2023", angepasste_themenskizze: "Building AI for interplanetary navigation", gesetzte_schwerpunkte: "Space, Navigation, AI", anmeldung_pruefungsamt: Date.new(2023, 6, 15), abgabedatum: Date.new(2023, 11, 15), studienniveau: "master", projekt_id: 2 }
]

konkrete_arbeiten_data.each do |arbeit_data|
  student = Student.find_by(matrikelnummer: arbeit_data[:matrikelnummer])
  
  if student.nil?
    puts "WARNING: Could not find student with matrikelnummer #{arbeit_data[:matrikelnummer]}. Skipping thesis."
    next
  end

  KonkreteAbschlussarbeit.find_or_create_by!(student: student) do |arbeit|
    arbeit.betreuer = arbeit_data[:betreuer]
    arbeit.forschungsprojekt = arbeit_data[:forschungsprojekt]
    arbeit.semester = arbeit_data[:semester]
    arbeit.matrikelnummer = arbeit_data[:matrikelnummer]
    arbeit.angepasste_themenskizze = arbeit_data[:angepasste_themenskizze]
    arbeit.gesetzte_schwerpunkte = arbeit_data[:gesetzte_schwerpunkte]
    arbeit.anmeldung_pruefungsamt = arbeit_data[:anmeldung_pruefungsamt]
    arbeit.abgabedatum = arbeit_data[:abgabedatum]
    arbeit.studienniveau = arbeit_data[:studienniveau]
    arbeit.projekt_id = arbeit_data[:projekt_id]
  end
end
puts "-> #{KonkreteAbschlussarbeit.count} concrete theses are now in the database."

puts "Seeding finished."