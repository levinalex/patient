class LabTest < ActiveRecord::Base
  belongs_to :lab_test_department
  belongs_to :lab_test_unit
  has_many :lab_test_normal_ranges
  has_many :lab_test_critical_ranges
  has_many :lab_test_linear_ranges
  has_many :lab_test_absurd_ranges
  has_many :lab_test_value_options
  has_many :lab_test_panel_joints, :dependent => :destroy
  has_many :lab_test_panels, :through => :lab_test_panel_joints
  has_many :lab_test_results, :dependent => :destroy
  has_many :accessions, :through => :lab_test_results
  has_many :lab_test_value_option_joints
  has_many :lab_test_values, :through => :lab_test_value_option_joints
  
  acts_as_list :scope => :lab_test_department

  default_scope :order => "position"
end
