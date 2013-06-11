class Artist < ActiveRecord::Base
  attr_accessible :id, :name
  has_many :tracks
  has_many :albums
  has_many :artist_aliases
end
