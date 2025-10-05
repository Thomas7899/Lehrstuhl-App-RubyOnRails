# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Student.create!(
    email: "Sabine@web.de",
    matrikelnummer: "123456",
    vorname: "Sabine",
    nachname: "Musterfrau",
    geburtsdatum: DateTime.new(2000, 9, 14))

Student.create!(
    email: "Sascha@web.de",
    matrikelnummer: "122456",
    vorname: "Sascha",
    nachname: "Mustermann",
    geburtsdatum: DateTime.new(1999, 5, 12))
