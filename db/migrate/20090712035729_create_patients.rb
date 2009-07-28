class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string :given_name
      t.string :middle_name
      t.string :family_name
      t.string :family_name2
      t.string :gender
      t.date :birthdate
      t.string :identifier
      t.text :address
      t.timestamps
    end
  end
  
  def self.down
    drop_table :patients
  end
end
