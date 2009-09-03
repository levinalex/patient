class AddGenderToDoctor < ActiveRecord::Migration
  def self.up
    add_column :doctors, :gender, :string
  end

  def self.down
    remove_column :doctors, :gender
  end
end
