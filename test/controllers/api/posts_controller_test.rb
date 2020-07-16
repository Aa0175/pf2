require 'test_helper'

class Api::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get api_posts_show_url
    assert_response :success
  end

end
