require 'test_helper'

class ArtistAliasesControllerTest < ActionController::TestCase
  setup do
    @artist_alias = artist_aliases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:artist_aliases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create artist_alias" do
    assert_difference('ArtistAlias.count') do
      post :create, artist_alias: { artist_id: @artist_alias.artist_id, name: @artist_alias.name }
    end

    assert_redirected_to artist_alias_path(assigns(:artist_alias))
  end

  test "should show artist_alias" do
    get :show, id: @artist_alias
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @artist_alias
    assert_response :success
  end

  test "should update artist_alias" do
    put :update, id: @artist_alias, artist_alias: { artist_id: @artist_alias.artist_id, name: @artist_alias.name }
    assert_redirected_to artist_alias_path(assigns(:artist_alias))
  end

  test "should destroy artist_alias" do
    assert_difference('ArtistAlias.count', -1) do
      delete :destroy, id: @artist_alias
    end

    assert_redirected_to artist_aliases_path
  end
end
