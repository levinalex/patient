class RenameLabTestPanelJointsToLabTestPanels < ActiveRecord::Migration
  def self.up
    rename_table :lab_test_panel_joints, :lab_test_panels
  end

  def self.down
    rename_table :lab_test_panels, :lab_test_panel_joints
  end
end
