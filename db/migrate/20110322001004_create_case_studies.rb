class CreateCaseStudies < ActiveRecord::Migration
  def self.up
    create_table :case_studies do |t|
      t.string :name
      t.text :summary
      t.boolean :party_type
      t.boolean :game_type
      t.boolean :issue_type
      t.boolean :delivery_type
      t.timestamps
    end
  end

  def self.down
    drop_table :case_studies
  end
end
