class Track < ActiveRecord::Base
  attr_accessible :album_artist, :album_id, :artist_id, :composer, :id, :name, :total_time, :track_no
  belongs_to :artist
  belongs_to :album
  has_many :user_tracks
end
