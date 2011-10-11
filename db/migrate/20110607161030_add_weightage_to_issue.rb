class AddWeightageToIssue < ActiveRecord::Migration
  def self.up
    add_column :issues, :weightage, :integer
  end

  def self.down
    remove_column :issues, :weightage
  end
end
