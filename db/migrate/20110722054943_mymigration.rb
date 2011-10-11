class Mymigration < ActiveRecord::Migration
  def self.up
	change_column_default(:student_routings,:post_neg_required,false)
	change_column_default(:student_routings,:pre_neg_required,false)
	change_column_default(:student_routings,:post_neg_taken,false)
	change_column_default(:student_routings,:pre_neg_taken,false)
	change_column_default(:student_routings,:planning_required,false)


  end

  def self.down
  end
end
