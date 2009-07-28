class Accession < ActiveRecord::Base
  belongs_to :patient
  belongs_to :order
  has_many :lab_test_results, :dependent => :destroy
  has_many :lab_tests, :through => :lab_test_results
end
