class CreateLabTestPanelJoints < ActiveRecord::Migration
  def self.up
    create_table :lab_test_panel_joints do |t|
      t.integer :lab_test_id
      t.integer :lab_test_panel_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lab_test_panel_joints
  end
end
