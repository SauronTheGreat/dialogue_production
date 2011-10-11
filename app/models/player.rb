require 'digest/sha1'

class Player < ActiveRecord::Base
  before_create :build_inbox

  attr_accessible :game_id, :user_id, :role_id
  belongs_to :game, :class_name=>"Game", :foreign_key => "game_id"
  delegate   :status,:agreement_status, :to => :game

  belongs_to :user, :class_name=>"User", :foreign_key => "user_id"
  delegate   :email, :to => :user

  belongs_to :role, :class_name=>"Role", :foreign_key => "role_id"
  delegate   :name, :to => :role

  has_many :scoreqs, :class_name=> 'Scoreq', :foreign_key => "player_id", :dependent => :destroy
  has_many :planqs, :class_name=> 'Planq', :foreign_key => "player_id", :dependent => :destroy
  has_many :player_scorecards, :class_name=> 'PlayerScorecard', :foreign_key => "player_id", :dependent => :destroy

  has_many :sent_messages, :class_name => "Message", :foreign_key => "author_id", :dependent => :destroy
  has_many :received_messages, :class_name => "MessageCopy", :foreign_key => "recipient_id", :dependent => :destroy
  has_many :folders, :dependent => :destroy

  has_one :student_routing, :dependent => :destroy

  def inbox
    folders.find_by_name("Inbox")
  end

  def build_inbox
    folders.build(:name => "Inbox")
  end

end
