class ArtistAliasesController < ApplicationController
  # GET /artist_aliases
  # GET /artist_aliases.json
  def index
    @artist_aliases = ArtistAlias.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @artist_aliases }
    end
  end

  # GET /artist_aliases/1
  # GET /artist_aliases/1.json
  def show
    @artist_alias = ArtistAlias.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @artist_alias }
    end
  end

  # GET /artist_aliases/new
  # GET /artist_aliases/new.json
  def new
    @artist_alias = ArtistAlias.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @artist_alias }
    end
  end

  # GET /artist_aliases/1/edit
  def edit
    @artist_alias = ArtistAlias.find(params[:id])
  end

  # POST /artist_aliases
  # POST /artist_aliases.json
  def create
    @artist_alias = ArtistAlias.new(params[:artist_alias])

    respond_to do |format|
      if @artist_alias.save
        format.html { redirect_to @artist_alias, notice: 'Artist alias was successfully created.' }
        format.json { render json: @artist_alias, status: :created, location: @artist_alias }
      else
        format.html { render action: "new" }
        format.json { render json: @artist_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /artist_aliases/1
  # PUT /artist_aliases/1.json
  def update
    @artist_alias = ArtistAlias.find(params[:id])

    respond_to do |format|
      if @artist_alias.update_attributes(params[:artist_alias])
        format.html { redirect_to @artist_alias, notice: 'Artist alias was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @artist_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artist_aliases/1
  # DELETE /artist_aliases/1.json
  def destroy
    @artist_alias = ArtistAlias.find(params[:id])
    @artist_alias.destroy

    respond_to do |format|
      format.html { redirect_to artist_aliases_url }
      format.json { head :no_content }
    end
  end
end
