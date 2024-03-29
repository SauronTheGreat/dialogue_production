class CreateIssueOptions < ActiveRecord::Migration
  def self.up
    create_table :issue_options do |t|
      t.integer :issue_id
      t.string :option
      t.integer :weightage
      t.timestamps
    end
  end

  def self.down
    drop_table :issue_options
  end
end
