require 'test_helper'

class LeadersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get leaders_index_url
    assert_response :success
  end

  test "should get new" do
    get leaders_new_url
    assert_response :success
  end

  test "should get show" do
    get leaders_show_url
    assert_response :success
  end

  test "should get edit" do
    get leaders_edit_url
    assert_response :success
  end

end
