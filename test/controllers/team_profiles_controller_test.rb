require 'test_helper'

class TeamProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get team_profiles_index_url
    assert_response :success
  end

  test "should get new" do
    get team_profiles_new_url
    assert_response :success
  end

  test "should get edit" do
    get team_profiles_edit_url
    assert_response :success
  end

  test "should get show" do
    get team_profiles_show_url
    assert_response :success
  end

end
