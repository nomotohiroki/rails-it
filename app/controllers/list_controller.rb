class ListController < ApplicationController
  def list
    key = params[:key]
    user = User.find_by_key_and_complete(params[:key], true)
    if user == nil
      render :template => "common/error.html", :status => :not_found
    else
      @artists = Artist.find(:all, :include => [{:albums => {:tracks => :user_tracks}}, :artist_aliases], :conditions => ["user_tracks.user_id = ? AND user_tracks.delete_flg = ?", user.id, false], :order => 'artists.name, albums.name, tracks.track_no')
    end
  end
end
