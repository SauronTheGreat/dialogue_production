class Offer < ActiveRecord::Base
  attr_accessible :game_id, :offerer, :value
  belongs_to :game, :class_name=>"Game", :foreign_key => "game_id"

end
