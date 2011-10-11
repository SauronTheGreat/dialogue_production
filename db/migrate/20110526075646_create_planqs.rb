class CreatePlanqs < ActiveRecord::Migration
  def self.up
    create_table :planqs do |t|
      t.integer :player_id
      t.string :meyou
      t.string :name
      t.string :value
      t.boolean :type
      t.timestamps
    end
  end

  def self.down
    drop_table :planqs
  end
end
