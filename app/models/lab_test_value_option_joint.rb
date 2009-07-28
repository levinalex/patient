class LabTestValueOptionJoint < ActiveRecord::Base
  belongs_to :lab_test_value
  belongs_to :lab_test_value_option
end
