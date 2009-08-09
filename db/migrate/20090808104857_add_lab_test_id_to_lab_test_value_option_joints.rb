class AddLabTestIdToLabTestValueOptionJoints < ActiveRecord::Migration
  def self.up
    add_column :lab_test_value_option_joints, :lab_test_id, :integer
    remove_column :lab_test_value_option_joints, :lab_test_value_option_id
  end

  def self.down
    remove_column :lab_test_value_option_joints, :lab_test_id
    add_column :lab_test_value_option_joints, :lab_test_value_option_id, :integer
  end
end
