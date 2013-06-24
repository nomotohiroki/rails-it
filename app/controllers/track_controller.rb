class TrackController < ApplicationController
  def detail
    track = Track.find(params[:id])
    render :json => track
  end

  def delete
    user = User.find_by_key(params[:key])
    userTrack = nil
    if user != nil
      userTrack = UserTrack.find_by_user_id_and_track_id(user.id, params[:id])
      userTrack.update_attribute("delete_flg", true);
    end
    render :json => userTrack
  end
end
