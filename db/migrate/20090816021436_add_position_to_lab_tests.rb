class AddPositionToLabTests < ActiveRecord::Migration
  def self.up
    add_column :lab_tests, :position, :integer
  end

  def self.down
    remove_column :lab_tests, :position
  end
end
