class LabTestValueOption < ActiveRecord::Base
  belongs_to :lab_test
  has_many :lab_test_value_option_joints
  has_many :lab_test_values, :through => :lab_test_value_option_joints
end
