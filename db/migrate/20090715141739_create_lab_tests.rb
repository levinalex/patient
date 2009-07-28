class CreateLabTests < ActiveRecord::Migration
  def self.up
    create_table :lab_tests do |t|
      t.string :code
      t.string :name
      t.text :description
      t.integer :decimals
      t.timestamps
    end
  end
  
  def self.down
    drop_table :lab_tests
  end
end
