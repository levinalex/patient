class AddReportedByColumnToAccession < ActiveRecord::Migration
  def self.up
    add_column :accessions, :reported_by, :integer
  end

  def self.down
    remove_column :accessions, :reported_by
  end
end
