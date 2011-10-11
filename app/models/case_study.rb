class CaseStudy < ActiveRecord::Base

  #Relationships
  attr_accessible :name, :summary, :party_type, :game_type, :issue_type, :delivery_type, :eval_type ,:case_study_type
  has_many :issues, :class_name=>"Issue", :foreign_key => "case_study_id", :dependent => :destroy
  has_many :roles, :class_name=>"Role", :foreign_key => "case_study_id", :dependent => :destroy
  has_many :student_groups, :class_name=>"StudentGroup", :foreign_key => "case_study_id"
  has_many :games, :class_name=>"Game", :foreign_key => "case_study_id", :dependent => :destroy

  #Validations
  validates_presence_of :name
  validates_presence_of :case_study_type
  validates_uniqueness_of :name



end
