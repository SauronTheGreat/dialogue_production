class CreatePlayerAnswers < ActiveRecord::Migration
  def self.up
    create_table :player_answers do |t|
      t.integer :player_id
      t.integer :question_id
      t.text :answer

      t.timestamps
    end
  end

  def self.down
    drop_table :player_answers
  end
end
