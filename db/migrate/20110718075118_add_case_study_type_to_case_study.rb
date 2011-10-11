class AddCaseStudyTypeToCaseStudy < ActiveRecord::Migration
  def self.up
    add_column :case_studies, :case_study_type, :integer
  end

  def self.down
    remove_column :case_studies, :case_study_type
  end
end
