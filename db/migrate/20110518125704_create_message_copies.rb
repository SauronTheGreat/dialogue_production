class CreateMessageCopies < ActiveRecord::Migration
  def self.up
    create_table :message_copies do |t|
      t.integer :recipient_id
      t.integer :message_id
      t.integer :folder_id

      t.timestamps
    end
  end

  def self.down
    drop_table :message_copies
  end
end
