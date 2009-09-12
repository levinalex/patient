class AddAdditionalAuthlogicFields < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string   :last_login_ip
      t.string   :current_login_ip
      t.integer  :login_count, :null => false, :default => 0
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :last_request_at
      t.remove :last_login_at
      t.remove :current_login_at
      t.remove :last_login_ip
      t.remove :current_login_ip
      t.remove :login_count
    end
  end
end
