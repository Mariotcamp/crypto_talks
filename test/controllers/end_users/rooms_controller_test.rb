require 'test_helper'

class EndUsers::RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get lowroom" do
    get end_users_rooms_lowroom_url
    assert_response :success
  end

  test "should get midroom" do
    get end_users_rooms_midroom_url
    assert_response :success
  end

  test "should get upperroom" do
    get end_users_rooms_upperroom_url
    assert_response :success
  end

end
