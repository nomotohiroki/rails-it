class ListController < ApplicationController
  def list
    key = params[:key]
    user = User.find_by_key(params[:key])
    @artists = Artist.find(:all, :include => {:tracks => [:user_tracks, :album]}, :conditions => {:user_tracks => {:user_id => user.id}}, :order => 'artists.name, albums.name')

  end
end
