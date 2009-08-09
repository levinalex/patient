class Accession < ActiveRecord::Base
  after_update :save_results
  
  belongs_to :patient
  belongs_to :order
  has_many :lab_test_results, :dependent => :destroy
  has_many :lab_tests, :through => :lab_test_results
  
  validates_presence_of :patient_id
  #must have at least one lab_test
  
  named_scope :reported, lambda { {:conditions => ['reported_at <= ?', Time.now.utc]} }
  named_scope :unreported, lambda { {:conditions => ['reported_at > ?', Time.now.utc]} }
  
  def derivate_result_value(code)
    code
  end
  
  def test_coded_as(code)
    lab_test = LabTest.find_by_code(code)
    unless lab_test_results.find(:first, :conditions => { :lab_test_id => lab_test }).nil?
      lab_test_results.find(:first, :conditions => { :lab_test_id => lab_test }).value.to_d
    else
      0
    end
  end
  
  def ldl
    test_coded_as("CHOL") - test_coded_as("HDL") - 0.2 * test_coded_as("TRIG")
  end
  
  def existing_result_attributes=(result_attributes)
    lab_test_results.reject(&:new_record?).each do |result|
      attributes = result_attributes[result.id.to_s]
      if attributes['_delete'] == '1'
        results.delete(task)
      else
        result.attributes = attributes
      end
    end
  end

  private

  def save_results
    lab_test_results.each do |result|
      result.save(false)
    end
  end
end
