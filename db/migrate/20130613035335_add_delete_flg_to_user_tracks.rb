class AddDeleteFlgToUserTracks < ActiveRecord::Migration
  def change
    add_column :user_tracks, :delete_flg, :boolean
  end
end
