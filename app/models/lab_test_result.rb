class LabTestResult < ActiveRecord::Base
  belongs_to :lab_test
  belongs_to :accession
  
  #validates_presence_of :accession_id, :lab_test_id
  
  def department
    lab_test.lab_test_department.name
  end

  def range_min
    # Missing age component to calculate valid range, instead of calling first
    unless lab_test.lab_test_normal_ranges.blank?
      range_min = lab_test.lab_test_normal_ranges.for_its_gender(accession.patient.gender).for_its_age(accession.patient.age).first.min
      ApplicationController.helpers.number_with_precision(range_min, :precision => lab_test.decimals, :delimiter => ',')
    end
  end

  def range_max
    # Missing age component to calculate valid range (see above)
    unless lab_test.lab_test_normal_ranges.blank?
      range_max = lab_test.lab_test_normal_ranges.for_its_gender(accession.patient.gender).for_its_age(accession.patient.age).first.max
      ApplicationController.helpers.number_with_precision(range_max, :precision => lab_test.decimals, :delimiter => ',')
    end
  end
  
  def range
    if range_min
      if range_max
        [range_min, "-", range_max].join(' ')
      else
        [">", range_min].join(' ')
      end
    else
      if range_max
        ["<", range_max].join(' ')
      else
        ""
      end
    end
  end
end
