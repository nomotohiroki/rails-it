class AddTrackRateToUserTracks < ActiveRecord::Migration
  def change
    add_column :user_tracks, :track_rate, :integer
  end
end
