class ImagesController < ApplicationController
  before_action :set_album
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def new
    @image = @album.images.new
  end

  def create
    @image = @album.images.create(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to album_path(@album), notice: 'Image was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_album
    @album = Album.find(params[:album_id])
  end

  def set_image
    @image = Image.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:album_id, :title, :date_taken, :album_image)
  end
end
