class LabTestResult < ActiveRecord::Base
  belongs_to :lab_test
  belongs_to :accession
    
  def department
    lab_test.lab_test_department.name
  end

  def range_min
  # Improve this... will fail if there is a range for a particular sex, does not take into account all possible gender values (i.e. M, F, U)
    unless lab_test.lab_test_normal_ranges.blank?
      lab_test.lab_test_normal_ranges.find(:first, :conditions => [ "gender = ?", "*"]).min.to_s
    end
  end

  def range_max
  # Improve this (see above)
    unless lab_test.lab_test_normal_ranges.blank?
      lab_test.lab_test_normal_ranges.find(:first, :conditions => [ "gender = ?", "*"]).max.to_s
    end
  end
  
end
