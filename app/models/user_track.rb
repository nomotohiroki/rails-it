class UserTrack < ActiveRecord::Base
  attr_accessible :delete_flg, :id, :track_id, :user_id
  belongs_to :track
  belongs_to :user
end
