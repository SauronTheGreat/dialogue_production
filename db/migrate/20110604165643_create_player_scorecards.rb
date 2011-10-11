class CreatePlayerScorecards < ActiveRecord::Migration
  def self.up
    create_table :player_scorecards do |t|
      t.integer :player_id
      t.integer :issue_id
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table :player_scorecards
  end
end
