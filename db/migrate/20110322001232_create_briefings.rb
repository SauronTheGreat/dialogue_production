class CreateBriefings < ActiveRecord::Migration
  def self.up
    create_table :briefings do |t|
      t.integer :role_id
      t.text :briefing_note
      t.timestamps
    end
  end

  def self.down
    drop_table :briefings
  end
end
