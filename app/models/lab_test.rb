class LabTest < ActiveRecord::Base
  #translates :name, :description
  #http://github.com/joshmh/globalize2/tree/master
  belongs_to :department
  belongs_to :unit
  has_many :reference_ranges
  has_many :lab_test_panels, :dependent => :destroy
  has_many :panels, :through => :lab_test_panels
  has_many :results, :dependent => :destroy
  has_many :accessions, :through => :results
  has_many :lab_test_value_option_joints, :dependent => :destroy
  has_many :lab_test_values, :through => :lab_test_value_option_joints
  
  acts_as_list :scope => :department

  default_scope :order => "position"
end
