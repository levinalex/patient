class AddDerivationToLabTest < ActiveRecord::Migration
  def self.up
    add_column :lab_tests, :derivation, :boolean
  end

  def self.down
    remove_column :lab_tests, :derivation
  end
end
