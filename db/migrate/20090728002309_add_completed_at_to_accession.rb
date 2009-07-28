class AddCompletedAtToAccession < ActiveRecord::Migration
  def self.up
    add_column :accessions, :completed_at, :datetime
  end

  def self.down
    remove_column :accessions, :completed_at
  end
end
