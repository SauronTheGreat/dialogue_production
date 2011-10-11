class AddPlayerIdToStudentRouting < ActiveRecord::Migration
  def self.up
    add_column :student_routings, :player_id, :integer
  end

  def self.down
    remove_column :student_routings, :player_id
  end
end
