require 'test_helper'

class Admin::GendersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_genders_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_genders_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_genders_edit_url
    assert_response :success
  end

end
