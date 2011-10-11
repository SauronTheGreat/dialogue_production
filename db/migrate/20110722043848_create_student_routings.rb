class CreateStudentRoutings < ActiveRecord::Migration
  def self.up
    create_table :student_routings do |t|
      t.boolean :pre_neg_taken
      t.boolean :post_neg_taken
      t.boolean :pre_neg_required
      t.boolean :post_neg_required
      t.boolean :planning_required


      t.timestamps
    end
  end

  def self.down
    drop_table :student_routings
  end
end
