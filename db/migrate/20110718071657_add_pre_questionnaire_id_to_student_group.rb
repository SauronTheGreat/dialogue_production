class AddPreQuestionnaireIdToStudentGroup < ActiveRecord::Migration
  def self.up
    add_column :student_groups, :pre_questionnaire_id, :integer
  end

  def self.down
    remove_column :student_groups, :pre_questionnaire_id
  end
end
