class CreateAlbumGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :album_groups do |t|
      t.references :group, foreign_key: true
      t.references :album, foreign_key: true

      t.timestamps
    end
  end
end
