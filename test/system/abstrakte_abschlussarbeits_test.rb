require "application_system_test_case"

class AbstrakteAbschlussarbeitsTest < ApplicationSystemTestCase
  setup do
    @abstrakte_abschlussarbeit = abstrakte_abschlussarbeits(:one)
  end

  test "visiting the index" do
    visit abstrakte_abschlussarbeits_url
    assert_selector "h1", text: "Abstrakte abschlussarbeits"
  end

  test "should create abstrakte abschlussarbeit" do
    visit abstrakte_abschlussarbeits_url
    click_on "New abstrakte abschlussarbeit"

    fill_in "Betreuer", with: @abstrakte_abschlussarbeit.betreuer
    fill_in "Forschungsprojekt", with: @abstrakte_abschlussarbeit.forschungsprojekt
    fill_in "Projekt", with: @abstrakte_abschlussarbeit.projekt_id
    fill_in "Semester", with: @abstrakte_abschlussarbeit.semester
    fill_in "Thema", with: @abstrakte_abschlussarbeit.thema
    fill_in "Themenskizze", with: @abstrakte_abschlussarbeit.themenskizze
    click_on "Create Abstrakte abschlussarbeit"

    assert_text "Abstrakte abschlussarbeit was successfully created"
    click_on "Back"
  end

  test "should update Abstrakte abschlussarbeit" do
    visit abstrakte_abschlussarbeit_url(@abstrakte_abschlussarbeit)
    click_on "Edit this abstrakte abschlussarbeit", match: :first

    fill_in "Betreuer", with: @abstrakte_abschlussarbeit.betreuer
    fill_in "Forschungsprojekt", with: @abstrakte_abschlussarbeit.forschungsprojekt
    fill_in "Projekt", with: @abstrakte_abschlussarbeit.projekt_id
    fill_in "Semester", with: @abstrakte_abschlussarbeit.semester
    fill_in "Thema", with: @abstrakte_abschlussarbeit.thema
    fill_in "Themenskizze", with: @abstrakte_abschlussarbeit.themenskizze
    click_on "Update Abstrakte abschlussarbeit"

    assert_text "Abstrakte abschlussarbeit was successfully updated"
    click_on "Back"
  end

  test "should destroy Abstrakte abschlussarbeit" do
    visit abstrakte_abschlussarbeit_url(@abstrakte_abschlussarbeit)
    click_on "Destroy this abstrakte abschlussarbeit", match: :first

    assert_text "Abstrakte abschlussarbeit was successfully destroyed"
  end
end
