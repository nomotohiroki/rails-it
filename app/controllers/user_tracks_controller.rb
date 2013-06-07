class UserTracksController < ApplicationController
  # GET /user_tracks
  # GET /user_tracks.json
  def index
    @user_tracks = UserTrack.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_tracks }
    end
  end

  # GET /user_tracks/1
  # GET /user_tracks/1.json
  def show
    @user_track = UserTrack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_track }
    end
  end

  # GET /user_tracks/new
  # GET /user_tracks/new.json
  def new
    @user_track = UserTrack.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_track }
    end
  end

  # GET /user_tracks/1/edit
  def edit
    @user_track = UserTrack.find(params[:id])
  end

  # POST /user_tracks
  # POST /user_tracks.json
  def create
    @user_track = UserTrack.new(params[:user_track])

    respond_to do |format|
      if @user_track.save
        format.html { redirect_to @user_track, notice: 'User track was successfully created.' }
        format.json { render json: @user_track, status: :created, location: @user_track }
      else
        format.html { render action: "new" }
        format.json { render json: @user_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_tracks/1
  # PUT /user_tracks/1.json
  def update
    @user_track = UserTrack.find(params[:id])

    respond_to do |format|
      if @user_track.update_attributes(params[:user_track])
        format.html { redirect_to @user_track, notice: 'User track was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_tracks/1
  # DELETE /user_tracks/1.json
  def destroy
    @user_track = UserTrack.find(params[:id])
    @user_track.destroy

    respond_to do |format|
      format.html { redirect_to user_tracks_url }
      format.json { head :no_content }
    end
  end
end
