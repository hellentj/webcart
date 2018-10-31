require "application_system_test_case"

class QuantitiesTest < ApplicationSystemTestCase
  setup do
    @quantity = quantities(:one)
  end

  test "visiting the index" do
    visit quantities_url
    assert_selector "h1", text: "Quantities"
  end

  test "creating a Quantity" do
    visit quantities_url
    click_on "New Quantity"

    click_on "Create Quantity"

    assert_text "Quantity was successfully created"
    click_on "Back"
  end

  test "updating a Quantity" do
    visit quantities_url
    click_on "Edit", match: :first

    click_on "Update Quantity"

    assert_text "Quantity was successfully updated"
    click_on "Back"
  end

  test "destroying a Quantity" do
    visit quantities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Quantity was successfully destroyed"
  end
end
