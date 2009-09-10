class AddPhoneToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :phone, :string, :limit => 32
    add_column :patients, :email, :string, :limit => 64
  end

  def self.down
    remove_column :patients, :phone
    remove_column :patients, :email
  end
end
