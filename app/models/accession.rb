class Accession < ActiveRecord::Base
  belongs_to :patient
  belongs_to :order
  has_many :lab_test_results, :dependent => :destroy
  has_many :lab_tests, :through => :lab_test_results
  named_scope :reported, lambda { {:conditions => ['reported_at <= ?', Time.now.utc]} }
  named_scope :unreported, lambda { {:conditions => ['reported_at > ?', Time.now.utc]} }
  
  def find_by_code(code)
    LabTest.find_by_code(code)
  end

  def test_coded_as(code)
    lab_test = find_by_code(code)
    lab_test_results.find(:first, :conditions => { :lab_test_id => lab_test }).value.to_d
  end
  
  def ldl
    test_coded_as("CHOL") - test_coded_as("HDL") - 0.2 * test_coded_as("TRIG")
  end
end
