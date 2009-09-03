class RenameLabTestUnitIdToUnitId < ActiveRecord::Migration
  UNIT_CHILD_TABLES = %w[
      lab_tests
    ]

  def self.up
    UNIT_CHILD_TABLES.each do |table|
      rename_column table, :lab_test_unit_id, :unit_id
    end
  end

  def self.down
    UNIT_CHILD_TABLES.each do |table|
      rename_column table, :unit_id, :lab_test_unit_id
    end
  end
end
