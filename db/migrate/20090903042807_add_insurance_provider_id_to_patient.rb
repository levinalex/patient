class AddInsuranceProviderIdToPatient < ActiveRecord::Migration
  def self.up
    add_column :patients, :insurance_provider_id, :integer
  end

  def self.down
    remove_column :patients, :insurance_provider_id
  end
end
