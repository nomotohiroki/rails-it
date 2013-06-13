class RemoveDeleteFlgFromTracks < ActiveRecord::Migration
  def up
    remove_column :tracks, :delete_flg
  end

  def down
    add_column :tracks, :delete_flg, :boolean
  end
end
