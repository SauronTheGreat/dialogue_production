class PlayerScorecard < ActiveRecord::Base
  attr_accessible :game_id, :player_id, :issue_id, :issue_option_id, :value
  belongs_to :game, :class_name=>"Game", :foreign_key => "game_id"
  belongs_to :player, :class_name=>"Player", :foreign_key => "player_id"
  belongs_to :issue, :class_name=>"Issue", :foreign_key => "issue_id"

end
