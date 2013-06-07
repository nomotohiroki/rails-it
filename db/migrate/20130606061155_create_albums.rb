class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :id
      t.string :name
      t.integer :artist_id
      t.integer :track_count

      t.timestamps
    end
  end
end
