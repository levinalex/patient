class CreateLabTestValueOptions < ActiveRecord::Migration
  def self.up
    create_table :lab_test_value_options do |t|
      t.boolean :numeric
      t.boolean :ratio
      t.boolean :range
      t.boolean :fraction
      t.integer :text_length
      t.integer :lab_test_value_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :lab_test_value_options
  end
end
