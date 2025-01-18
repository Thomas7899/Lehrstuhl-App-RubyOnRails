require "test_helper"

class KonkreteAbschlussarbeitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @konkrete_abschlussarbeit = konkrete_abschlussarbeits(:one)
  end

  test "should get index" do
    get konkrete_abschlussarbeits_url
    assert_response :success
  end

  test "should get new" do
    get new_konkrete_abschlussarbeit_url
    assert_response :success
  end

  test "should create konkrete_abschlussarbeit" do
    assert_difference("KonkreteAbschlussarbeit.count") do
      post konkrete_abschlussarbeits_url, params: { konkrete_abschlussarbeit: { abgabedatum: @konkrete_abschlussarbeit.abgabedatum, angepasste_themenskizze: @konkrete_abschlussarbeit.angepasste_themenskizze, anmeldung_pruefungsamt: @konkrete_abschlussarbeit.anmeldung_pruefungsamt, betreuer: @konkrete_abschlussarbeit.betreuer, forschungsprojekt: @konkrete_abschlussarbeit.forschungsprojekt, gesetzte_schwerpunkte: @konkrete_abschlussarbeit.gesetzte_schwerpunkte, matrikelnummer: @konkrete_abschlussarbeit.matrikelnummer, semester: @konkrete_abschlussarbeit.semester, student_id: @konkrete_abschlussarbeit.student_id, studienniveau: @konkrete_abschlussarbeit.studienniveau } }
    end

    assert_redirected_to konkrete_abschlussarbeit_url(KonkreteAbschlussarbeit.last)
  end

  test "should show konkrete_abschlussarbeit" do
    get konkrete_abschlussarbeit_url(@konkrete_abschlussarbeit)
    assert_response :success
  end

  test "should get edit" do
    get edit_konkrete_abschlussarbeit_url(@konkrete_abschlussarbeit)
    assert_response :success
  end

  test "should update konkrete_abschlussarbeit" do
    patch konkrete_abschlussarbeit_url(@konkrete_abschlussarbeit), params: { konkrete_abschlussarbeit: { abgabedatum: @konkrete_abschlussarbeit.abgabedatum, angepasste_themenskizze: @konkrete_abschlussarbeit.angepasste_themenskizze, anmeldung_pruefungsamt: @konkrete_abschlussarbeit.anmeldung_pruefungsamt, betreuer: @konkrete_abschlussarbeit.betreuer, forschungsprojekt: @konkrete_abschlussarbeit.forschungsprojekt, gesetzte_schwerpunkte: @konkrete_abschlussarbeit.gesetzte_schwerpunkte, matrikelnummer: @konkrete_abschlussarbeit.matrikelnummer, semester: @konkrete_abschlussarbeit.semester, student_id: @konkrete_abschlussarbeit.student_id, studienniveau: @konkrete_abschlussarbeit.studienniveau } }
    assert_redirected_to konkrete_abschlussarbeit_url(@konkrete_abschlussarbeit)
  end

  test "should destroy konkrete_abschlussarbeit" do
    assert_difference("KonkreteAbschlussarbeit.count", -1) do
      delete konkrete_abschlussarbeit_url(@konkrete_abschlussarbeit)
    end

    assert_redirected_to konkrete_abschlussarbeits_url
  end
end
