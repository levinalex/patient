class LabTestUnit < ActiveRecord::Base
  has_many :lab_tests
  default_scope :order => "name"
end
