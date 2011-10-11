class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.integer :player_id
      t.boolean :inout
      t.boolean :newreply
      t.string :to_players
      t.string :from_player
      t.string :subject
      t.text :mail_body
      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
