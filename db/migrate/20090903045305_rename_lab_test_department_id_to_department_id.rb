class RenameLabTestDepartmentIdToDepartmentId < ActiveRecord::Migration
  DEPARTMENT_CHILD_TABLES = %w[
      lab_tests
    ]
    
  def self.up
    DEPARTMENT_CHILD_TABLES.each do |table|
      rename_column table, :lab_test_department_id, :department_id
    end
  end

  def self.down
    DEPARTMENT_CHILD_TABLES.each do |table|
      rename_column table, :department_id, :lab_test_department_id
    end
  end
end
