class FixAccessions < ActiveRecord::Migration
  def self.up
    change_table :accessions do |t|
      t.remove :specimen_type_id
      t.remove :other_id
      t.remove :labels
      t.remove :stat
      t.remove :note
      t.remove :diagnosis
    end
    add_index :accessions, [:patient_id, :doctor_id]
  end

  def self.down
    change_table :accessions do |t|
      t.references :specimen_type
      t.references :other
      t.integer :labels
      t.boolean :stat
      t.text :note
      t.decimal :diagnosis
    end
    remove_index :accessions, [:patient_id, :doctor_id]
  end
end
