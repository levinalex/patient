class LabTestValue < ActiveRecord::Base
  has_many :lab_test_value_option_joints
  has_many :lab_tests, :through => :lab_test_value_option_joints
end
