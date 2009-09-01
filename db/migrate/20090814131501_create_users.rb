class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :crypted_password,   :null => false
      t.string :password_salt,      :null => false
      t.string :persistence_token,  :null => false
      # >>> The following fields are required and maintained by [authlogic] plugin.
#      t.string   :password_hash,    :null => false, :default => ""
#      t.string   :password_salt,    :null => false, :default => ""
#      t.string   :remember_token,   :null => false, :default => ""
#      t.string   :perishable_token, :null => false, :default => ""
#      t.string   :openid_identifier
#      t.datetime :last_request_at
#      t.datetime :last_login_at
#      t.datetime :current_login_at
#      t.string   :last_login_ip
#      t.string   :current_login_ip
#      t.integer  :login_count,      :null => false, :default => 0
      # >>> End of [authlogic] maintained fields.
      t.timestamps
    end
  end
  
  def self.down
    drop_table :users
  end
end
