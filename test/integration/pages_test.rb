require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest
  test "Should go to Home Page" do
  get pages_home_url
  assert_response :success
  end
  
  test "Should get root routes" do
    get root_url
    assert_response :success
  end
end
