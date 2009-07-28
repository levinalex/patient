class AddLabTestIdToLabTestNormalRange < ActiveRecord::Migration
  def self.up
    add_column :lab_test_normal_ranges, :lab_test_id, :integer
  end

  def self.down
    remove_column :lab_test_normal_ranges, :lab_test_id
  end
end
