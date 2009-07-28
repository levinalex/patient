class RemoveLabTestValueIdFromLabTestValueOptions < ActiveRecord::Migration
  def self.up
    remove_column :lab_test_value_options, :lab_test_value_id
  end

  def self.down
    add_column :lab_test_value_options, :lab_test_value_id, :integer
  end
end
