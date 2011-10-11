class Scoreq < ActiveRecord::Base
  attr_accessible :player_id, :student_group_metric_id, :value, :message_id
  belongs_to :student_group_metric, :class_name=> 'StudentGroupMetric', :foreign_key => "student_group_metric_id"
  belongs_to :player, :class_name=> 'Player', :foreign_key => "player_id"
  belongs_to :message, :class_name=> 'Message', :foreign_key => "message_id"


end
