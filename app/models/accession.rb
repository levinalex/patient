class Accession < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  belongs_to :patient
  belongs_to :doctor
  has_many :results, :dependent => :destroy
  has_many :lab_tests, :through => :results
  has_many :accession_panels, :dependent => :destroy
  has_many :panels, :through => :accession_panels
  has_many :notes, :as => :noticeable
  
  accepts_nested_attributes_for :results, :allow_destroy => true
  accepts_nested_attributes_for :accession_panels, :allow_destroy => true
  
  validates_presence_of :patient_id
  validates_associated :results
  
  named_scope :recently, :order => 'updated_at DESC'
  named_scope :reported, :conditions => 'reported_at IS NOT NULL'
  named_scope :pending, :conditions => { :reported_at => nil }

  before_save :process_panel_selection
  after_update :save_results

  def result_attributes=(result_attributes)
    results.reject(&:new_record?).each do |result|
      unless result.lab_test.derivation
        attributes = result_attributes[result.id.to_s]
        if attributes['_delete'] == '1'
          results.delete(result)
        else
          result.attributes = attributes
        end
      end
    end
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
  
  # Does not erase a previous doctor
  def doctor_name=(name)
    self.doctor = Doctor.find_or_create_by_name(name) unless (name.blank? or name == "—")
  end

  def order_list
    list = []
    panel_list = []
    lab_test_list = []
    panels.each do |panel|
      list << panel.code
      panel.lab_tests.each do |lab_test|
        panel_list << lab_test.code
      end
    end
    lab_tests.each do |lab_test|
      lab_test_list << lab_test.code
    end
    list << lab_test_list - panel_list unless (lab_test_list -panel_list).empty?
    list.join(', ')
  end
  
  ##
  # Derivative test definitions
  # TODO: Grab a formula from the derivation field
  # TODO: In the meantime, refactor the current formulas
  #

  def mch
    if result_of_test_coded_as("HGB") && result_of_test_coded_as("RBC")
      result_of_test_coded_as("HGB") / result_of_test_coded_as("RBC") * 10
    else
      "calc."
    end
  end
#  memoize :mch
  
  def mchc
    if result_of_test_coded_as("HGB") && result_of_test_coded_as("HCT")
      result_of_test_coded_as("HGB") * 100 / result_of_test_coded_as("HCT")
    else
      "calc."
    end
  end
#  memoize :mchc
  
  def ldl
    if result_of_test_coded_as("CHOL") && result_of_test_coded_as("HDL") && result_of_test_coded_as("TRIG")
      result_of_test_coded_as("CHOL") - result_of_test_coded_as("HDL") - 0.2 * result_of_test_coded_as("TRIG")
    else
      "calc."
    end
  end
#  memoize :ldl
  
  def ibil
    if result_of_test_coded_as("TBIL") && result_of_test_coded_as("DBIL")
      result_of_test_coded_as("TBIL") - result_of_test_coded_as("DBIL")
    else
      "calc."
    end
  end
#  memoize :ibil

  def glo
    if result_of_test_coded_as("TP") && result_of_test_coded_as("ALB")
      result_of_test_coded_as("TP") - result_of_test_coded_as("ALB")
    else
      "calc."
    end
  end
#  memoize :glo
  
  private

  def result_of_test_coded_as(code)
    lab_test = LabTest.find_by_code(code)
    if lab_test
      results.find_by_lab_test_id(lab_test).value.to_d unless results.find_by_lab_test_id(lab_test).value.blank?
    end
  end

  def process_panel_selection
    # Save previous results before overwriting them (http://github.com/jlduran/patient/issues#issue/2)
    self.panels.each do |panel|
      self.lab_test_ids |= panel.lab_test_ids
    end
  end

  def save_results
    results.each do |result|
      result.save(false)
    end
  end
end
