class AddAlbumImageToImage < ActiveRecord::Migration[5.0]
  def change
    add_attachment :images, :album_image
  end
end
