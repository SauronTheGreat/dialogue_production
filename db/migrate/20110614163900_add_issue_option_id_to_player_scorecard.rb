class AddIssueOptionIdToPlayerScorecard < ActiveRecord::Migration
  def self.up
    add_column :player_scorecards, :issue_option_id, :integer
  end

  def self.down
    remove_column :player_scorecards, :issue_option_id
  end
end
