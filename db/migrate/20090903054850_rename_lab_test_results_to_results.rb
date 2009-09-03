class RenameLabTestResultsToResults < ActiveRecord::Migration
  def self.up
    rename_table :lab_test_results, :results
  end

  def self.down
    rename_table :results, :lab_test_results
  end
end
