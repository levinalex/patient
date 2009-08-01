class LabTestCriticalRange < ActiveRecord::Base
  belongs_to :lab_test
  named_scope :females, :conditions => { :gender => [F, *] }
  named_scope :males, :conditions => { :gender => [M, *] }
end
