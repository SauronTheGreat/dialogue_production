class Issue < ActiveRecord::Base
  attr_accessible :case_study_id, :name, :flag, :weightage
  belongs_to :case_study, :class_name=>"CaseStudy", :foreign_key => "case_study_id"
  has_many :player_scorecards, :class_name=> 'PlayerScorecard', :foreign_key => "issue_id", :dependent => :destroy
  has_many :issue_options, :class_name=> 'IssueOption', :foreign_key => "issue_id", :dependent => :destroy
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :case_study_id

end
