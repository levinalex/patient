class AddDoctorIdToAccession < ActiveRecord::Migration
  def self.up
    add_column :accessions, :doctor_id, :integer
  end

  def self.down
    remove_column :accessions, :doctor_id
  end
end
