class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :statement
      t.integer :questionnaire_id
      t.integer :type_id
      t.integer :category_id
      t.text :answer

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
