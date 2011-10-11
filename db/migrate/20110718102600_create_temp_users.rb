class CreateTempUsers < ActiveRecord::Migration
  def self.up
    create_table :temp_users do |t|
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :temp_users
  end
end
