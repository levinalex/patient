class LabTestDepartment < ActiveRecord::Base
  has_many :lab_tests, :dependent => :destroy
end
