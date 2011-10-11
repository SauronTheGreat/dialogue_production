class CreateStudentGroupUsers < ActiveRecord::Migration
  def self.up
    create_table :student_group_users do |t|
      t.integer :student_group_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :student_group_users
  end
end
