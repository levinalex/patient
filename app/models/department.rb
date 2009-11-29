class Department < ActiveRecord::Base
  has_many :lab_tests, :dependent => :destroy
  has_many :notes, :as => :noticeable
  validates_presence_of :name
  validates_uniqueness_of :name
end
