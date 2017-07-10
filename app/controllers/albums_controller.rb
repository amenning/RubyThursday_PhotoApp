class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = current_member.albums
  end

  def show
    @images = @album.images
  end

  def new
    @album = current_member.albums.new
  end

  def edit
    1.times { @album.album_groups.build }
  end

  def create
    @album = current_member.albums.create(album_params)

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def album_params
    params.require(:album).permit(
      :title,
      :member_id,
      album_groups_attributes: [:album_id, :group_id]
    )
  end

  def set_album
    @album = Album.find(params[:id])
  end
end
