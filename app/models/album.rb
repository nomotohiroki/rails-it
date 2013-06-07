class Album < ActiveRecord::Base
  attr_accessible :id, :name, :track_count, :artist_id
  has_many :tracks
  belongs_to :artist
end
