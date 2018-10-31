require 'test_helper'

class QuantitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quantity = quantities(:one)
  end

  test "should get index" do
    get quantities_url
    assert_response :success
  end

  test "should get new" do
    get new_quantity_url
    assert_response :success
  end

  test "should create quantity" do
    assert_difference('Quantity.count') do
      post quantities_url, params: { quantity: {  } }
    end

    assert_redirected_to quantity_url(Quantity.last)
  end

  test "should show quantity" do
    get quantity_url(@quantity)
    assert_response :success
  end

  test "should get edit" do
    get edit_quantity_url(@quantity)
    assert_response :success
  end

  test "should update quantity" do
    patch quantity_url(@quantity), params: { quantity: {  } }
    assert_redirected_to quantity_url(@quantity)
  end

  test "should destroy quantity" do
    assert_difference('Quantity.count', -1) do
      delete quantity_url(@quantity)
    end

    assert_redirected_to quantities_url
  end
end
