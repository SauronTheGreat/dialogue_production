class Rule < ActiveRecord::Base
  #Relationships
    attr_accessible :name, :description
    has_many :student_group_rules, :class_name=> 'StudentGroupRule', :foreign_key => "rule_id", :dependent => :destroy

  #Validations
  validates_presence_of :name
  validates_presence_of :description


end
