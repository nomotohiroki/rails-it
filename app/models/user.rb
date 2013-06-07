class User < ActiveRecord::Base
  attr_accessible :complete, :created_on, :email, :id, :key, :library_path
  has_many :user_tracks
end
