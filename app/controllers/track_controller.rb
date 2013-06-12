class TrackController < ApplicationController
  def detail
    track = Track.find(params[:id])
    render :json => track
  end

  def delete
  end
end
