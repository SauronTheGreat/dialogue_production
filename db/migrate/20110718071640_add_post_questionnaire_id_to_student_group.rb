class AddPostQuestionnaireIdToStudentGroup < ActiveRecord::Migration
  def self.up
    add_column :student_groups, :post_questionnaire_id, :integer
  end

  def self.down
    remove_column :student_groups, :post_questionnaire_id
  end
end
