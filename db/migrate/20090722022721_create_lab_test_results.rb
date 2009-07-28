class CreateLabTestResults < ActiveRecord::Migration
  def self.up
    create_table :lab_test_results do |t|
      t.string :value
      t.integer :lab_test_id
      t.integer :accession_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :lab_test_results
  end
end
