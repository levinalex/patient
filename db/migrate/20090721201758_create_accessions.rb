class CreateAccessions < ActiveRecord::Migration
  def self.up
    create_table :accessions do |t|
      t.integer :patient_id
      t.integer :other_id
      t.integer :labels
      t.datetime :drawn_at
      t.integer :drawn_by
      t.integer :specimen_type_id
      t.datetime :received_at
      t.integer :received_by
      t.boolean :stat
      t.text :note
      t.decimal :diagnosis
      t.timestamps
    end
  end
  
  def self.down
    drop_table :accessions
  end
end
