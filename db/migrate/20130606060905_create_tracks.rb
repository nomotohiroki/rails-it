class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :id
      t.string :name
      t.integer :artist_id
      t.integer :album_id
      t.integer :album_artist
      t.integer :track_no
      t.string :composer
      t.integer :total_time

      t.timestamps
    end
  end
end
