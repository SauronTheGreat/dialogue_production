class AddPreviewOnToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :preview_on, :boolean
  end

  def self.down
    remove_column :users, :preview_on
  end
end
