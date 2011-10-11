class OptionValue < ActiveRecord::Base
  attr_accessible :issue_option_id, :role_id, :value
  belongs_to :issue_option, :class_name=>"IssueOption", :foreign_key => "issue_option_id"
  belongs_to :role, :class_name=>"Role", :foreign_key => "role_id"

end
