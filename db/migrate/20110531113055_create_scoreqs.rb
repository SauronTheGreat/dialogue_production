class CreateScoreqs < ActiveRecord::Migration
  def self.up
    create_table :scoreqs do |t|
      t.integer :player_id
      t.integer :student_group_metric_id
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table :scoreqs
  end
end
