class AddDeleteFlgToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :delete_flg, :boolean
  end
end
