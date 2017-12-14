require 'test_helper'

class Admin::HeightsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_heights_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_heights_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_heights_edit_url
    assert_response :success
  end

end
