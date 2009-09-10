class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :patients, :insurance_provider_id
    add_index :lab_tests, [:department_id, :unit_id]
    add_index :reference_ranges, :lab_test_id
  end

  def self.down
    remove_index :patients, :insurance_provider_id
    remove_index :lab_tests, [:department_id, :unit_id]
    remove_index :reference_ranges, :lab_test_id
  end
end
