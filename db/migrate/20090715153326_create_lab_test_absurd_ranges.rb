class CreateLabTestAbsurdRanges < ActiveRecord::Migration
  def self.up
    create_table :lab_test_absurd_ranges do |t|
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
    drop_table :lab_test_absurd_ranges
  end
end
