class AddLabTestUnitIdToLabTest < ActiveRecord::Migration
  def self.up
    add_column :lab_tests, :lab_test_unit_id, :integer
  end

  def self.down
    remove_column :lab_tests, :lab_test_unit_id
  end
end
