class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :student_group_id
      t.integer :case_study_id
      t.boolean :status
      t.boolean :agreement_status
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
