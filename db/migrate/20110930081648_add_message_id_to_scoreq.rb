class AddMessageIdToScoreq < ActiveRecord::Migration
  def self.up
    add_column :scoreqs, :message_id, :integer
  end

  def self.down
    remove_column :scoreqs, :message_id
  end
end
