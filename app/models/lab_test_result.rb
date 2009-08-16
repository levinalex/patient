class LabTestResult < ActiveRecord::Base
  belongs_to :lab_test
  belongs_to :accession
  
  #validates_presence_of :accession_id, :lab_test_id
  
  def department_name
    lab_test.lab_test_department.name
  end

  def lab_test_name
    lab_test.lab_test_department.name
  end
  
  def formatted_value
    if value.blank? || value.nil?
      if lab_test.derivation
        if accession.reported_at
          ApplicationController.helpers.number_with_precision(accession.send(lab_test.code.underscore), :precision => lab_test.decimals, :delimiter => ',')
        else
          "calc."
        end
      else
        "N/R"
      end
    else
      if lab_test.lab_test_values.blank?
        ApplicationController.helpers.number_with_precision(value, :precision => lab_test.decimals, :delimiter => ',')
      else
        LabTestValue.find(value).value
      end
    end
  end
  
  def value_number
    value.to_i
  end

  def value_number=(value)
    self.value = value
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
  
  def range_interval_symbol
    if range_max && range_min
      "–"
    elsif range_max
      "<"
    elsif range_min
      ">"
    else
      ""
    end
  end
  
  def range
    if range_min
      if range_max
        [range_min, "–", range_max].join(' ')
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
  
  def flag
    if !value.blank?
      if range_max
        if range_min
          if range_max.to_d >= value.to_d && range_min.to_d < value.to_d
            "normal_value"
          else
            if range_max.to_d < value.to_d
              "high_value"
            else
              "low_value"
            end
          end
        else
          if range_max.to_d < value.to_d
            "high_value"
          else
            "normal_value"
          end
        end
      else
        if range_min
          if range_min.to_d >= value.to_d
            "low_value"
          else
            "normal_value"
          end
        else
          "normal_value"
        end
      end
    else
      "normal_value"
    end
  end
end
