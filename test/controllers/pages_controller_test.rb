require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest 
    test "Home is accessible by anyone" do 
        get root_path 
        assert_response :success
    end 
end 