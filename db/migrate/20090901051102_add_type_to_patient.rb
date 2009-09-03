class AddTypeToPatient < ActiveRecord::Migration
  def self.up
    add_column :patients, :type, :integer
  end

  def self.down
    remove_column :patients, :type
  end
end
