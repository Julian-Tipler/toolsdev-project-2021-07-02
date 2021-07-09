require "application_system_test_case"

class TemperaturesTest < ApplicationSystemTestCase
  setup do
    @temperature = temperatures(:one)
  end

  test "visiting the index" do
    visit temperatures_url
    assert_selector "h1", text: "Temperatures"
  end

  test "creating a Temperature" do
    visit temperatures_url
    click_on "New Temperature"

    fill_in "Datetime", with: @temperature.datetime
    fill_in "Temperature", with: @temperature.temperature
    click_on "Create Temperature"

    assert_text "Temperature was successfully created"
    click_on "Back"
  end

  test "updating a Temperature" do
    visit temperatures_url
    click_on "Edit", match: :first

    fill_in "Datetime", with: @temperature.datetime
    fill_in "Temperature", with: @temperature.temperature
    click_on "Update Temperature"

    assert_text "Temperature was successfully updated"
    click_on "Back"
  end

  test "destroying a Temperature" do
    visit temperatures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Temperature was successfully destroyed"
  end
end
