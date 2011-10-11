class CreateRules < ActiveRecord::Migration
  def self.up
    create_table :rules do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    Rule.create :name=>'In-Game Survey', :description=>'The In-Game Survey is a mechanism to track the perceptual differences which a sender and a recipient have when writing and reading the same mail. Tracking the same can be an effective way to understand the dynamics of success of a negotiation.'
    Rule.create :name=>'Planning Document', :description=>'A critical part of all negotiations, it is important to be prepared and clear about your position before you meet at the table.'

  end

  def self.down
    drop_table :rules
  end
end
