class StudentGroupMetric < ActiveRecord::Base
  attr_accessible :student_group_id, :metric_id

  belongs_to :student_group, :class_name=> 'StudentGroup', :foreign_key => "student_group_id"
  belongs_to :metric, :class_name=> 'Metric', :foreign_key => "metric_id"
  delegate   :name,:description, :to => :metric
  
  has_many :scoreqs, :class_name=> 'Scoreq', :foreign_key => "student_group_metric_id", :dependent => :destroy

end
