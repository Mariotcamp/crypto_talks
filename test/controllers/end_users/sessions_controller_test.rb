require 'test_helper'

class EndUsers::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get end_users_sessions_new_url
    assert_response :success
  end

end
