class MessageCopy < ActiveRecord::Base
  belongs_to :message
  belongs_to :recipient, :class_name => "Player"
  belongs_to :folder
  delegate   :author, :created_at, :subject, :body, :recipients, :offer, :to => :message
end
