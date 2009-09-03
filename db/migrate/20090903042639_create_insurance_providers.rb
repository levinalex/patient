class CreateInsuranceProviders < ActiveRecord::Migration
  def self.up
    create_table :insurance_providers do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :insurance_providers
  end
end
