class CreateLabTestUnits < ActiveRecord::Migration
  def self.up
    create_table :lab_test_units do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :lab_test_units
  end
end
