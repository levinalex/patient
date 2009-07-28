class CreateLabTestPanels < ActiveRecord::Migration
  def self.up
    create_table :lab_test_panels do |t|
      t.string :code
      t.string :name
      t.string :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :lab_test_panels
  end
end
