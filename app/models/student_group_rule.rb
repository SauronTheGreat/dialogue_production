class StudentGroupRule < ActiveRecord::Base
  attr_accessible :student_group_id, :rule_id

  belongs_to :student_group, :class_name=> 'StudentGroup', :foreign_key => "student_group_id"
  belongs_to :rule, :class_name=> 'Rule', :foreign_key => "rule_id"
  delegate   :name,:description, :to => :rule


end
