class Unit < ActiveRecord::Base
  #translates :name
  has_many :lab_tests
  default_scope :order => "name"
end
