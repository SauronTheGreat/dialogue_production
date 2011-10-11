class Message < ActiveRecord::Base
  
  validates_presence_of :to, :message=>" whom? The message needs to have at least one recipient"

  belongs_to :author, :class_name => "Player"
  has_many :message_copies
  has_many :scoreqs
  has_many :recipients, :through => :message_copies
  before_create :prepare_copies

  attr_accessor  :to # array of people to send to
  attr_accessible :subject, :body, :to, :offer

  def prepare_copies
    return if to.blank?

    to.each do |recipient|
      recipient = Player.find(recipient)
      message_copies.build(:recipient_id => recipient.id, :folder_id => recipient.inbox.id)
    end
  end

end
