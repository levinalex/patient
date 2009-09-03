class Accession < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  belongs_to :patient
  belongs_to :doctor
  has_many :results, :dependent => :destroy
  has_many :lab_tests, :through => :results
  has_many :accession_panels, :dependent => :destroy
  has_many :panels, :through => :accession_panels
  
  accepts_nested_attributes_for :results, :allow_destroy => true
  accepts_nested_attributes_for :accession_panels, :allow_destroy => true
  
  validates_presence_of :patient_id
  
  named_scope :recent, :order => 'updated_at DESC', :limit => 10
  named_scope :reported, :conditions => 'reported_at IS NOT NULL'
  named_scope :pending, :conditions => { :reported_at => nil }
  
  before_save :process_panel_selection
  
  def result_of_test_coded_as(code)
    lab_test = LabTest.find_by_code(code)
    results.find_by_lab_test_id(lab_test).value.to_d unless results.find_by_lab_test_id(lab_test).value.blank?
  end

  def patient_age
    days_per_year = 365.25
    if drawn_at
      age = ((drawn_at.to_date - patient.birthdate).to_i / days_per_year).floor
    else
      age = ((Date.today - patient.birthdate).to_i / days_per_year).floor
    end
  end
  
  def doctor_name
    if doctor
      doctor.name
    else
      "—"
    end
  end
  
  ##
  # Derivative test definitions
  # Eventually will grab a formula from the derivation field
  #
  
  def ldl
    if result_of_test_coded_as("CHOL") && result_of_test_coded_as("HDL") && result_of_test_coded_as("TRIG")
      result_of_test_coded_as("CHOL") - result_of_test_coded_as("HDL") - 0.2 * result_of_test_coded_as("TRIG")
    else
      "calc."
    end
  end
  memoize :ldl
  
  private
  
  def process_panel_selection
    self.panels.each do |panel|
      self.lab_test_ids |= panel.lab_test_ids
    end
  end
end
