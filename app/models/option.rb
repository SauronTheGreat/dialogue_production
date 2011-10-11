class Option < ActiveRecord::Base
  attr_accessible :question_id, :name
  belongs_to :question
end
