class AddFlagToIssue < ActiveRecord::Migration
  def self.up
    add_column :issues, :flag, :string
  end

  def self.down
    remove_column :issues, :flag
  end
end
