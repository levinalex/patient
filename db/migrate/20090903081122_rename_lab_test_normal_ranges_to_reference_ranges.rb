class RenameLabTestNormalRangesToReferenceRanges < ActiveRecord::Migration
  def self.up
    rename_table :lab_test_normal_ranges, :reference_ranges
  end

  def self.down
    rename_table :reference_ranges, :lab_test_normal_ranges
  end
end
