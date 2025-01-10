json.extract! student, :id, :email, :matrikelnummer, :vorname, :nachname, :geburtsdatum, :created_at, :updated_at
json.url student_url(student, format: :json)
