class CreateLabTestNormalRanges < ActiveRecord::Migration
  def self.up
    create_table :lab_test_normal_ranges do |t|
      t.decimal :min
      t.decimal :max
      t.string :gender
      t.integer :min_age
      t.integer :max_age
      t.string :age_unit
      t.timestamps
    end
  end
  
  def self.down
    drop_table :lab_test_normal_ranges
  end
end
