class GameData < ActiveRecord::Base
  attr_accessible :game_id, :data_of, :data_is, :value
end
