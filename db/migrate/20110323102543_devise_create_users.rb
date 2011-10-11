class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|

      t.integer :facilitator_group_id
      t.string :first_name
      t.string :last_name
      t.string :identifier
      t.string :username
      t.boolean :educator
      t.boolean :admin

      t.database_authenticatable :null => false
      # t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      # t.lockable

      t.timestamps
    end

   User.create(:facilitator_group_id=>"1",:first_name=>"",:last_name=>"",:identifier=>"",:username=>"admin",:email=>"arijit@ptotem.com",:password=>"p20o20e13",:password_confirmation=>"p20o20e13",:admin=>TRUE,:educator=>FALSE)


    add_index :users, :username,               :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    add_index :users, :reset_password_token, :unique => true
#    add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users
  end
end
