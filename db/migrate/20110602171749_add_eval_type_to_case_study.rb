class AddEvalTypeToCaseStudy < ActiveRecord::Migration
  def self.up
    add_column :case_studies, :eval_type, :boolean
  end

  def self.down
    remove_column :case_studies, :eval_type
  end
end
