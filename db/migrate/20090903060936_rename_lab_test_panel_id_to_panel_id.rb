class RenameLabTestPanelIdToPanelId < ActiveRecord::Migration
  PANEL_CHILD_TABLES = %w[
      lab_test_panel_joints accession_panels
    ]

  def self.up
    PANEL_CHILD_TABLES.each do |table|
      rename_column table, :lab_test_panel_id, :panel_id
    end
  end

  def self.down
    PANEL_CHILD_TABLES.each do |table|
      rename_column table, :panel_id, :lab_test_panel_id
    end
  end
end
