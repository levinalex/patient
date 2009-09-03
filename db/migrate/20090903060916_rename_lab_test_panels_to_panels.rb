class RenameLabTestPanelsToPanels < ActiveRecord::Migration
  def self.up
    rename_table :lab_test_panels, :panels
  end

  def self.down
    rename_table :panels, :lab_test_panels
  end
end
