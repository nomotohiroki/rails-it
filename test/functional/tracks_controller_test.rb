require 'test_helper'

class TracksControllerTest < ActionController::TestCase
  setup do
    @track = tracks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tracks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create track" do
    assert_difference('Track.count') do
      post :create, track: { album_artist: @track.album_artist, album_id: @track.album_id, artist_id: @track.artist_id, composer: @track.composer, id: @track.id, name: @track.name, total_time: @track.total_time, track_no: @track.track_no }
    end

    assert_redirected_to track_path(assigns(:track))
  end

  test "should show track" do
    get :show, id: @track
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @track
    assert_response :success
  end

  test "should update track" do
    put :update, id: @track, track: { album_artist: @track.album_artist, album_id: @track.album_id, artist_id: @track.artist_id, composer: @track.composer, id: @track.id, name: @track.name, total_time: @track.total_time, track_no: @track.track_no }
    assert_redirected_to track_path(assigns(:track))
  end

  test "should destroy track" do
    assert_difference('Track.count', -1) do
      delete :destroy, id: @track
    end

    assert_redirected_to tracks_path
  end
end
