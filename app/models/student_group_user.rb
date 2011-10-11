class StudentGroupUser < ActiveRecord::Base
  attr_accessible :student_group_id, :user_id
  belongs_to :student_group, :class_name=> 'StudentGroup', :foreign_key => "student_group_id"
  belongs_to :user, :class_name=> 'User', :foreign_key => "user_id"
  delegate :first_name, :last_name, :identifier, :email, :to=>:user
end
