class CreateLabTestValues < ActiveRecord::Migration
  def self.up
    create_table :lab_test_values do |t|
      t.string :value
      t.string :flag
      t.text :note
      t.timestamps
    end
  end
  
  def self.down
    drop_table :lab_test_values
  end
end
