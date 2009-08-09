class AddOptionsToLabTest < ActiveRecord::Migration
  def self.up
    add_column :lab_tests, :also_numeric, :boolean
    add_column :lab_tests, :ratio, :boolean
    add_column :lab_tests, :range, :boolean
    add_column :lab_tests, :fraction, :boolean
    add_column :lab_tests, :text_length, :integer
  end

  def self.down
    remove_column :lab_tests, :text_length
    remove_column :lab_tests, :fraction
    remove_column :lab_tests, :range
    remove_column :lab_tests, :ratio
    remove_column :lab_tests, :also_numeric
  end
end
