class CreateOffers < ActiveRecord::Migration
  def self.up
    create_table :offers do |t|
      t.integer :game_id
      t.integer :offerer
      t.integer :value
      t.integer :sequence
      t.timestamps
    end
  end

  def self.down
    drop_table :offers
  end
end
