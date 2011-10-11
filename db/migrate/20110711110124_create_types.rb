class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types do |t|
      t.string :name
      t.timestamps
    end

    Type.create :name=>'Multiple Choice Question'
    Type.create :name=>'True/False'
    Type.create :name=>'5-Point Rating Scale'
    Type.create :name=>'7-Point Rating Scale'
    Type.create :name=>'Open-Ended'

  end

  def self.down
    drop_table :types
  end
end
