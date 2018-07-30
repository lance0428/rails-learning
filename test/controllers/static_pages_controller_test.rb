require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "home title" do
    get static_pages_home_url
    assert_select "title", "Home"
  end

end
