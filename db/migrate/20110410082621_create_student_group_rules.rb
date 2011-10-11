class CreateStudentGroupRules < ActiveRecord::Migration
  def self.up
    create_table :student_group_rules do |t|
      t.integer :student_group_id
      t.integer :rule_id

      t.timestamps
    end
  end

  def self.down
    drop_table :student_group_rules
  end
end
