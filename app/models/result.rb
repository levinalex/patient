class Result < ActiveRecord::Base
  belongs_to :accession
  belongs_to :lab_test
  belongs_to :lab_test_value
  
  def department_name
    lab_test.department.name
  end

  def formatted_value
    if value.blank? && lab_test_value.nil?
      if lab_test.derivation
        ApplicationController.helpers.number_with_precision(accession.send(lab_test.code.underscore), :precision => lab_test.decimals, :delimiter => ',')
      else
        "pend."
      end
    elsif lab_test_value
      lab_test_value.value
    else
      if lab_test.also_numeric
        ApplicationController.helpers.number_with_precision(value, :precision => lab_test.decimals, :delimiter => ',')
#      elsif lab_test.ratio
#      elsif lab_test.range
#      elsif lab_test.fraction
#      elsif lab_test.text
      else
        ApplicationController.helpers.number_with_precision(value, :precision => lab_test.decimals, :delimiter => ',')
      end
    end
  end

  def range_min
    # Missing age component to calculate valid range, instead of calling first
    unless lab_test.lab_test_normal_ranges.blank?
      range_min = lab_test.lab_test_normal_ranges.for_its_gender(accession.patient.gender).for_its_age(accession.patient_age).first.min
      ApplicationController.helpers.number_with_precision(range_min, :precision => lab_test.decimals, :delimiter => ',')
    end
  end

  def range_max
    # Missing age component to calculate valid range (see above)
    unless lab_test.lab_test_normal_ranges.blank?
      range_max = lab_test.lab_test_normal_ranges.for_its_gender(accession.patient.gender).for_its_age(accession.patient_age).first.max
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
    end
  end
  
  def range
    if range_max && range_min
      [range_min, range_interval_symbol, range_max].join(' ')
    elsif range_max
      [range_interval_symbol, range_max].join(' ')
    elsif range_min
      [range_interval_symbol, range_min].join(' ')
    end
  end

  def flag_color
    if value.blank? && lab_test_value.nil?
      if lab_test.derivation
        check_range
      else
        "normal_value"
      end
    elsif lab_test_value
      case lab_test_value.flag
      when "A"
        "abnormal_value"
      when "H"
        "high_value"
      when "L"
        "low_value"
      else
        "normal_value"
      end
    else
#      if lab_test.also_numeric
#      elsif lab_test.ratio
#      elsif lab_test.range
#      elsif lab_test.fraction
#      elsif lab_test.text_length
#      else
        check_range
#      end
    end
  end
    
  def flag
    case flag_color
    when "high_value"
      I18n.translate('results.high')
    when "low_value"
      I18n.translate('results.low')
    when "abnormal_value"
      I18n.translate('results.abnormal')
    end
  end

private

  def check_range
    if range_max && range_min
      if range_max.to_d < formatted_value.to_d
        "high_value"
      elsif range_min.to_d >= formatted_value.to_d
        "low_value"
      else
        "normal_value"
      end
    elsif range_max
      if range_max.to_d < formatted_value.to_d
        "high_value"
      else
        "normal_value"
      end
    elsif range_min
      if range_min.to_d >= formatted_value.to_d
        "low_value"
      else
        "normal_value"
      end
    else
      "normal_value"
    end
  end
end
