class Accession < ActiveRecord::Base
  belongs_to :patient
  belongs_to :order
  has_many :lab_test_results, :dependent => :destroy
  has_many :lab_tests, :through => :lab_test_results
  has_many :accession_panels, :dependent => :destroy
  has_many :lab_test_panels, :through => :accession_panels
  
  accepts_nested_attributes_for :lab_test_results, :allow_destroy => true
  accepts_nested_attributes_for :accession_panels, :allow_destroy => true
  
  validates_presence_of :patient_id
  
  named_scope :recent, :order => 'updated_at DESC'
  #named_scope :reported, lambda { {:conditions => ['reported_at <= ?', Time.now.utc]} }
  named_scope :unreported, :conditions => { :reported_at => nil }
    
  def result_of_test_coded_as(code)
    lab_test = LabTest.find_by_code(code)
    lab_test_results.find_by_lab_test_id(lab_test).value.to_d unless lab_test_results.find_by_lab_test_id(lab_test).nil?
  end
  
  ##
  # Derivative test definitions
  # Eventually will grab a formula from the derivation field
  # (must be changed from boolean to string)
  #
  
  def ldl
    if result_of_test_coded_as("CHOL") && result_of_test_coded_as("HDL") && result_of_test_coded_as("TRIG")
      result_of_test_coded_as("CHOL") - result_of_test_coded_as("HDL") - 0.2 * result_of_test_coded_as("TRIG")
    else
      "calc."
    end
  end
end
