require 'test_helper'

class UploadControllerTest < ActionController::TestCase
  test "should get uploadItunesXml" do
    get :uploadItunesXml
    assert_response :success
  end

end
