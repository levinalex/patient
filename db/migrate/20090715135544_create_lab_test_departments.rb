class CreateLabTestDepartments < ActiveRecord::Migration
  def self.up
    create_table :lab_test_departments do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :lab_test_departments
  end
end
