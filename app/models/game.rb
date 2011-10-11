class Game < ActiveRecord::Base
  attr_accessible :student_group_id, :case_study_id, :status, :agreement_status
  belongs_to :student_group, :class_name=>"StudentGroup", :foreign_key => "student_group_id"
  belongs_to :case_study, :class_name=>"CaseStudy", :foreign_key => "case_study_id"
  has_many :players, :class_name=>"Player", :foreign_key => "game_id", :dependent=>:destroy
  has_many :offers, :class_name=>"Offer", :foreign_key => "game_id", :dependent=> :destroy

end
