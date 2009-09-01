class AddLabTestValueIdToLabTestResults < ActiveRecord::Migration
  def self.up
    add_column :lab_test_results, :lab_test_value_id, :integer
  end

  def self.down
    remove_column :lab_test_results, :lab_test_value_id
  end
end
