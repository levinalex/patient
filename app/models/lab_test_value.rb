class LabTestValue < ActiveRecord::Base
  has_many :lab_test_value_option_joints
  has_many :lab_tests, :through => :lab_test_value_option_joints
  
  def value_with_flag
    unless flag.blank?
      value.to_s + " (" + flag.to_s + ")"
    else
      value
    end
  end
end
