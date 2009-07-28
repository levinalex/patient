class LabTestResult < ActiveRecord::Base
  belongs_to :lab_test
  belongs_to :accession
    
  def range_min
  # Improve this... will fail if there is a range for a particular sex, does not take into account all possible sex values (i.e. *)
    unless lab_test.lab_test_normal_ranges.blank?
      self.lab_test.lab_test_normal_ranges.find(:first, :conditions => [ "gender = ?", self.accession.patient.gender || "*"]).min
    end
  end

  def range_max
  # Improve this (see above)
    unless lab_test.lab_test_normal_ranges.blank?
      self.lab_test.lab_test_normal_ranges.find(:first, :conditions => [ "gender = ?", self.accession.patient.gender || "*"]).max
    end
  end
  
end
