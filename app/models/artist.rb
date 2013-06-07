class Artist < ActiveRecord::Base
  attr_accessible :id, :name
  has_many :tracks
  has_many :albums
end
