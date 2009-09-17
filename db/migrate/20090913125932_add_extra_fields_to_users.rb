class AddExtraFieldsToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :first_name, :limit => 32
      t.string :last_name, :limit => 32
      t.string :prefix, :limit => 16
      t.string :suffix, :limit => 16
      t.boolean :admin, :null => false, :default => false
      t.remove :name_to_display
    end
    add_index :users, :username, :unique => true
    superuser = User.first
    superuser.update_attribute(:admin, true) if superuser
  end

  def self.down
    change_table :users do |t|
      t.string :name_to_display
      t.remove :first_name
      t.remove :last_name
      t.remove :prefix
      t.remove :suffix
      t.remove :admin
    end
    remove_index :users, :username
  end
end
