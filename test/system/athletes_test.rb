require "application_system_test_case"

class AthletesTest < ApplicationSystemTestCase
  setup do
    @athlete = athletes(:one)
  end

  test "visiting the index" do
    visit athletes_url
    assert_selector "h1", text: "Athletes"
  end

  test "should create athlete" do
    visit athletes_url
    click_on "New athlete"

    fill_in "Email", with: @athlete.email
    fill_in "First name", with: @athlete.first_name
    fill_in "Last name", with: @athlete.last_name
    fill_in "Phone", with: @athlete.phone
    click_on "Create Athlete"

    assert_text "Athlete was successfully created"
    click_on "Back"
  end

  test "should update Athlete" do
    visit athlete_url(@athlete)
    click_on "Edit this athlete", match: :first

    fill_in "Email", with: @athlete.email
    fill_in "First name", with: @athlete.first_name
    fill_in "Last name", with: @athlete.last_name
    fill_in "Phone", with: @athlete.phone
    click_on "Update Athlete"

    assert_text "Athlete was successfully updated"
    click_on "Back"
  end

  test "should destroy Athlete" do
    visit athlete_url(@athlete)
    click_on "Destroy this athlete", match: :first

    assert_text "Athlete was successfully destroyed"
  end
end
