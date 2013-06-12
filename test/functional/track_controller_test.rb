require 'test_helper'

class TrackControllerTest < ActionController::TestCase
  test "should get detail" do
    get :detail
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
