class LabTest < ActiveRecord::Base
  belongs_to :lab_test_department
  belongs_to :lab_test_unit
  has_many :lab_test_normal_ranges
  has_many :lab_test_critical_ranges
  has_many :lab_test_linear_ranges
  has_many :lab_test_absurd_ranges
  has_many :lab_test_value_options
  has_many :lab_test_panel_joints
  has_many :lab_test_panels, :through => :lab_test_panel_joints
  has_many :lab_test_results, :dependent => :destroy
  has_many :accessions, :through => :lab_test_results
end
