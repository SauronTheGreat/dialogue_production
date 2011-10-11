class AddGameIdToPlayerScorecards < ActiveRecord::Migration
  def self.up
    add_column :player_scorecards, :game_id, :integer
  end

  def self.down
    remove_column :player_scorecards, :game_id
  end
end
