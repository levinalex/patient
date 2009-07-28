class LabTestPanel < ActiveRecord::Base
  has_many :lab_test_panel_joints
  has_many :lab_tests, :through => :lab_test_panel_joints
end
