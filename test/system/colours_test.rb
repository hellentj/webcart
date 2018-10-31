require "application_system_test_case"

class ColoursTest < ApplicationSystemTestCase
  setup do
    @colour = colours(:one)
  end

  test "visiting the index" do
    visit colours_url
    assert_selector "h1", text: "Colours"
  end

  test "creating a Colour" do
    visit colours_url
    click_on "New Colour"

    click_on "Create Colour"

    assert_text "Colour was successfully created"
    click_on "Back"
  end

  test "updating a Colour" do
    visit colours_url
    click_on "Edit", match: :first

    click_on "Update Colour"

    assert_text "Colour was successfully updated"
    click_on "Back"
  end

  test "destroying a Colour" do
    visit colours_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Colour was successfully destroyed"
  end
end
