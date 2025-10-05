require "test_helper"

class AbstrakteAbschlussarbeitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @abstrakte_abschlussarbeit = abstrakte_abschlussarbeits(:one)
  end

  test "should get index" do
    get abstrakte_abschlussarbeits_url
    assert_response :success
  end

  test "should get new" do
    get new_abstrakte_abschlussarbeit_url
    assert_response :success
  end

  test "should create abstrakte_abschlussarbeit" do
    assert_difference("AbstrakteAbschlussarbeit.count") do
      post abstrakte_abschlussarbeits_url, params: { abstrakte_abschlussarbeit: { betreuer: @abstrakte_abschlussarbeit.betreuer, forschungsprojekt: @abstrakte_abschlussarbeit.forschungsprojekt, projekt_id: @abstrakte_abschlussarbeit.projekt_id, semester: @abstrakte_abschlussarbeit.semester, thema: @abstrakte_abschlussarbeit.thema, themenskizze: @abstrakte_abschlussarbeit.themenskizze } }
    end

    assert_redirected_to abstrakte_abschlussarbeit_url(AbstrakteAbschlussarbeit.last)
  end

  test "should show abstrakte_abschlussarbeit" do
    get abstrakte_abschlussarbeit_url(@abstrakte_abschlussarbeit)
    assert_response :success
  end

  test "should get edit" do
    get edit_abstrakte_abschlussarbeit_url(@abstrakte_abschlussarbeit)
    assert_response :success
  end

  test "should update abstrakte_abschlussarbeit" do
    patch abstrakte_abschlussarbeit_url(@abstrakte_abschlussarbeit), params: { abstrakte_abschlussarbeit: { betreuer: @abstrakte_abschlussarbeit.betreuer, forschungsprojekt: @abstrakte_abschlussarbeit.forschungsprojekt, projekt_id: @abstrakte_abschlussarbeit.projekt_id, semester: @abstrakte_abschlussarbeit.semester, thema: @abstrakte_abschlussarbeit.thema, themenskizze: @abstrakte_abschlussarbeit.themenskizze } }
    assert_redirected_to abstrakte_abschlussarbeit_url(@abstrakte_abschlussarbeit)
  end

  test "should destroy abstrakte_abschlussarbeit" do
    assert_difference("AbstrakteAbschlussarbeit.count", -1) do
      delete abstrakte_abschlussarbeit_url(@abstrakte_abschlussarbeit)
    end

    assert_redirected_to abstrakte_abschlussarbeits_url
  end
end
