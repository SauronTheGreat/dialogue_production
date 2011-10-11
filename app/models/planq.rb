class Planq < ActiveRecord::Base
  attr_accessible :player_id, :meyou, :name, :value, :type
  belongs_to :player, :class_name=> 'Player', :foreign_key => "player_id"

end
