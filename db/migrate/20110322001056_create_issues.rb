class CreateIssues < ActiveRecord::Migration
  def self.up
    create_table :issues do |t|
      t.integer :case_study_id
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :issues
  end
end
