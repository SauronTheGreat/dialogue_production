class Folder < ActiveRecord::Base
  acts_as_tree
  belongs_to :player
  has_many :messages, :class_name => "MessageCopy", :dependent => :destroy
end
