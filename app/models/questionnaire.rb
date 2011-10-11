class Questionnaire < ActiveRecord::Base
  #Relationships
  has_many :questions,:dependent => :destroy
  belongs_to :user

  #Validations
  validates_presence_of :user_id
  validates_presence_of :name

end

