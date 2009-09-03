class InsuranceProvider < ActiveRecord::Base
  attr_accessible :name
  has_many :patients
end
