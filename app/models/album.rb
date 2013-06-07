class Album < ActiveRecord::Base
  attr_accessible :id, :name, :track_count
  has_many :tracks
end
