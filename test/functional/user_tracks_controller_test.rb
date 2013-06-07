require 'test_helper'

class UserTracksControllerTest < ActionController::TestCase
  setup do
    @user_track = user_tracks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_tracks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_track" do
    assert_difference('UserTrack.count') do
      post :create, user_track: { id: @user_track.id, track_id: @user_track.track_id, user_id: @user_track.user_id }
    end

    assert_redirected_to user_track_path(assigns(:user_track))
  end

  test "should show user_track" do
    get :show, id: @user_track
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_track
    assert_response :success
  end

  test "should update user_track" do
    put :update, id: @user_track, user_track: { id: @user_track.id, track_id: @user_track.track_id, user_id: @user_track.user_id }
    assert_redirected_to user_track_path(assigns(:user_track))
  end

  test "should destroy user_track" do
    assert_difference('UserTrack.count', -1) do
      delete :destroy, id: @user_track
    end

    assert_redirected_to user_tracks_path
  end
end
