class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options do |t|
      t.string :name
      t.integer :question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :options
  end
end
