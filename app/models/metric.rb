class Metric < ActiveRecord::Base

  #Relationships
  attr_accessible :name, :description
  has_many :student_group_metrics, :class_name=>"StudentGroupMetric", :foreign_key => "metric_id", :dependent => :destroy
  validates_presence_of :name, :description
end
