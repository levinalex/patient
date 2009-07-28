class CreateLabTestCriticalRanges < ActiveRecord::Migration
  def self.up
    create_table :lab_test_critical_ranges do |t|
      t.decimal :min
      t.decimal :max
      t.string :gender
      t.integer :min_age
      t.integer :max_age
      t.string :age_unit
      t.integer :lab_test_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :lab_test_critical_ranges
  end
end
