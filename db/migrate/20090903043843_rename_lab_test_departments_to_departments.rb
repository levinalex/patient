class RenameLabTestDepartmentsToDepartments < ActiveRecord::Migration
  def self.up
    rename_table :lab_test_departments, :departments
  end

  def self.down
    rename_table :departments, :lab_test_departments
  end
end
