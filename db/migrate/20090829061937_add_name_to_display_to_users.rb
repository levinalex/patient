class AddNameToDisplayToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name_to_display, :string
  end

  def self.down
    remove_column :users, :name_to_display
  end
end
