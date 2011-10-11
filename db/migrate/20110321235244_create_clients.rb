class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.string :client_type
      t.timestamps
    end

    Client.create(:name=> "Ptotem Learning Projects",:client_type=>"Other")
  end

  def self.down
    drop_table :clients
  end
end
