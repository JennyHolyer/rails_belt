require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get login_reg" do
    get users_login_reg_url
    assert_response :success
  end

end
