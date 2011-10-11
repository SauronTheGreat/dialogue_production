class CreateGameDatas < ActiveRecord::Migration
  def self.up
    create_table :game_datas do |t|
      t.integer :game_id
      t.string :data_of
      t.string :data_is
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table :game_datas
  end
end
