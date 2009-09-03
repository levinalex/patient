class RenameLabTestUnitsToUnits < ActiveRecord::Migration
  def self.up
    rename_table :lab_test_units, :units
  end

  def self.down
    rename_table :units, :lab_test_units
  end
end
