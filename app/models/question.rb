class Question < ActiveRecord::Base

  has_many :options,:dependent => :destroy
  belongs_to :questionnaire
  belongs_to :type
  belongs_to :category

  #these are validations

  validates_presence_of :questionnaire_id
  validates_presence_of :type_id
  validates_presence_of :statement





  end