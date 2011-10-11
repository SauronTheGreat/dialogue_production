class CreateOptionValues < ActiveRecord::Migration
  def self.up
    create_table :option_values do |t|
      t.integer :issue_option_id
      t.integer :role_id
      t.integer :value
      t.timestamps
    end
  end

  def self.down
    drop_table :option_values
  end
end
