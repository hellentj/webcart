require 'test_helper'

class ColoursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @colour = colours(:one)
  end

  test "should get index" do
    get colours_url
    assert_response :success
  end

  test "should get new" do
    get new_colour_url
    assert_response :success
  end

  test "should create colour" do
    assert_difference('Colour.count') do
      post colours_url, params: { colour: {  } }
    end

    assert_redirected_to colour_url(Colour.last)
  end

  test "should show colour" do
    get colour_url(@colour)
    assert_response :success
  end

  test "should get edit" do
    get edit_colour_url(@colour)
    assert_response :success
  end

  test "should update colour" do
    patch colour_url(@colour), params: { colour: {  } }
    assert_redirected_to colour_url(@colour)
  end

  test "should destroy colour" do
    assert_difference('Colour.count', -1) do
      delete colour_url(@colour)
    end

    assert_redirected_to colours_url
  end
end
