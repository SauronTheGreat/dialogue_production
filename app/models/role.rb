class Role < ActiveRecord::Base
  attr_accessible :case_study_id, :name
  belongs_to :case_study, :class_name=>"CaseStudy", :foreign_key => "case_study_id"
  has_one :briefing, :class_name=>"Briefing", :foreign_key => "role_id", :dependent => :destroy
  has_many :players, :class_name=>"Player", :foreign_key => "role_id", :dependent => :destroy
  has_many :option_values, :class_name=>"OptionValue", :foreign_key => "role_id", :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :case_study_id
end
