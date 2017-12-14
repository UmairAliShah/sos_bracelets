require 'test_helper'

class Admin::EyesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_eyes_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_eyes_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_eyes_edit_url
    assert_response :success
  end

end
