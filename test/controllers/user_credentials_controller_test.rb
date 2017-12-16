require 'test_helper'

class UserCredentialsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_credentials_new_url
    assert_response :success
  end

end
