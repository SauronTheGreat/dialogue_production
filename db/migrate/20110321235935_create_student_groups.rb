class CreateStudentGroups < ActiveRecord::Migration
  def self.up
    create_table :student_groups do |t|
      t.integer :facilitator_group_id
      t.integer :case_study_id
      t.string :facilitator
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :student_groups
  end
end
