require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get show_token" do
    get home_show_token_url
    assert_response :success
  end
end
