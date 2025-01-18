require "application_system_test_case"

class KonkreteAbschlussarbeitsTest < ApplicationSystemTestCase
  setup do
    @konkrete_abschlussarbeit = konkrete_abschlussarbeits(:one)
  end

  test "visiting the index" do
    visit konkrete_abschlussarbeits_url
    assert_selector "h1", text: "Konkrete abschlussarbeits"
  end

  test "should create konkrete abschlussarbeit" do
    visit konkrete_abschlussarbeits_url
    click_on "New konkrete abschlussarbeit"

    fill_in "Abgabedatum", with: @konkrete_abschlussarbeit.abgabedatum
    fill_in "Angepasste themenskizze", with: @konkrete_abschlussarbeit.angepasste_themenskizze
    fill_in "Anmeldung pruefungsamt", with: @konkrete_abschlussarbeit.anmeldung_pruefungsamt
    fill_in "Betreuer", with: @konkrete_abschlussarbeit.betreuer
    fill_in "Forschungsprojekt", with: @konkrete_abschlussarbeit.forschungsprojekt
    fill_in "Gesetzte schwerpunkte", with: @konkrete_abschlussarbeit.gesetzte_schwerpunkte
    fill_in "Matrikelnummer", with: @konkrete_abschlussarbeit.matrikelnummer
    fill_in "Semester", with: @konkrete_abschlussarbeit.semester
    fill_in "Student", with: @konkrete_abschlussarbeit.student_id
    fill_in "Studienniveau", with: @konkrete_abschlussarbeit.studienniveau
    click_on "Create Konkrete abschlussarbeit"

    assert_text "Konkrete abschlussarbeit was successfully created"
    click_on "Back"
  end

  test "should update Konkrete abschlussarbeit" do
    visit konkrete_abschlussarbeit_url(@konkrete_abschlussarbeit)
    click_on "Edit this konkrete abschlussarbeit", match: :first

    fill_in "Abgabedatum", with: @konkrete_abschlussarbeit.abgabedatum
    fill_in "Angepasste themenskizze", with: @konkrete_abschlussarbeit.angepasste_themenskizze
    fill_in "Anmeldung pruefungsamt", with: @konkrete_abschlussarbeit.anmeldung_pruefungsamt
    fill_in "Betreuer", with: @konkrete_abschlussarbeit.betreuer
    fill_in "Forschungsprojekt", with: @konkrete_abschlussarbeit.forschungsprojekt
    fill_in "Gesetzte schwerpunkte", with: @konkrete_abschlussarbeit.gesetzte_schwerpunkte
    fill_in "Matrikelnummer", with: @konkrete_abschlussarbeit.matrikelnummer
    fill_in "Semester", with: @konkrete_abschlussarbeit.semester
    fill_in "Student", with: @konkrete_abschlussarbeit.student_id
    fill_in "Studienniveau", with: @konkrete_abschlussarbeit.studienniveau
    click_on "Update Konkrete abschlussarbeit"

    assert_text "Konkrete abschlussarbeit was successfully updated"
    click_on "Back"
  end

  test "should destroy Konkrete abschlussarbeit" do
    visit konkrete_abschlussarbeit_url(@konkrete_abschlussarbeit)
    click_on "Destroy this konkrete abschlussarbeit", match: :first

    assert_text "Konkrete abschlussarbeit was successfully destroyed"
  end
end
