class CreateFacilitatorGroups < ActiveRecord::Migration
  def self.up
    create_table :facilitator_groups do |t|
      t.integer :client_id
      t.integer :user_id
      t.string :name
      t.timestamps
    end
    FacilitatorGroup.create(:client_id=> 1,:name=>"Administrators", :user_id=>1)

  end

  def self.down
    drop_table :facilitator_groups
  end
end
