class CreateLabTestValueOptionJoints < ActiveRecord::Migration
  def self.up
    create_table :lab_test_value_option_joints do |t|
      t.integer :lab_test_value_id
      t.integer :lab_test_value_option_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lab_test_value_option_joints
  end
end
