class AddProcedureToLabTest < ActiveRecord::Migration
  def self.up
    add_column :lab_tests, :procedure, :integer
  end

  def self.down
    remove_column :lab_tests, :procedure
  end
end
