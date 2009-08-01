class AddReportedAtColumnToAccession < ActiveRecord::Migration
  def self.up
    add_column :accessions, :reported_at, :datetime
  end

  def self.down
    remove_column :accessions, :reported_at
  end
end
