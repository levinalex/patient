class AddLabTestDepartmentIdToLabTest < ActiveRecord::Migration
  def self.up
    add_column :lab_tests, :lab_test_department_id, :integer
  end

  def self.down
    remove_column :lab_tests, :lab_test_department_id
  end
end
