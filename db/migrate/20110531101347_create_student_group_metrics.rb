class CreateStudentGroupMetrics < ActiveRecord::Migration
  def self.up
    create_table :student_group_metrics do |t|
      t.integer :student_group_id
      t.integer :metric_id
      t.timestamps
    end
  end

  def self.down
    drop_table :student_group_metrics
  end
end
