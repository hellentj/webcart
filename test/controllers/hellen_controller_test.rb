require 'test_helper'

class HellenControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get hellen_home_url
    assert_response :success
  end

end
