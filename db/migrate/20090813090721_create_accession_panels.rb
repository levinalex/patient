class CreateAccessionPanels < ActiveRecord::Migration
  def self.up
    create_table :accession_panels do |t|
      t.integer :accession_id
      t.integer :lab_test_panel_id

      t.timestamps
    end
  end

  def self.down
    drop_table :accession_panels
  end
end
