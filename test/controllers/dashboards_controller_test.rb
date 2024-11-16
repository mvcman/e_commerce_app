require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest 
    test "#show is accessible to signed-in users" do 
        sign_in users(:one)
        get dashboard_path 
        assert_response :success
    end 
end 