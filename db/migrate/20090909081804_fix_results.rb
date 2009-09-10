class FixResults < ActiveRecord::Migration
  def self.up
    add_index :results, [:accession_id, :lab_test_id, :lab_test_value_id]
  end

  def self.down
    remove_index :results, [:accession_id, :lab_test_id, :lab_test_value_id]
  end
end
