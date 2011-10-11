class Client < ActiveRecord::Base
  attr_accessible :name, :client_type
  has_many :facilitator_groups, :class_name=>"FacilitatorGroup", :foreign_key => "client_id", :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
end
