class AddAlbumToImages < ActiveRecord::Migration[5.0]
  def change
    add_reference :images, :album, foreign_key: true
  end
end
