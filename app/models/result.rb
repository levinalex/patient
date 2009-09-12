class Result < ActiveRecord::Base
  belongs_to :accession
  belongs_to :lab_test
  belongs_to :lab_test_value
  
  def department_name
    lab_test.department.name
  end

  def formatted_value
    if lab_test.derivation
      format_value(accession.send(lab_test.code.underscore))
    elsif lab_test_value
      lab_test_value.value
    elsif lab_test.ratio? || lab_test.range? || lab_test.fraction? || lab_test.text_length?
      value
    elsif value.blank?
      "pend."
    else
      format_value(value)
    end
  end

  def range_min
    # Missing age component to calculate valid range, instead of calling first
    unless lab_test.reference_ranges.blank?
      range_min = lab_test.reference_ranges.for_its_gender(accession.patient.gender).for_its_age(accession.patient_age).first.min
      format_value(range_min)
    end
  end

  def range_max
    # Missing age component to calculate valid range (see above)
    unless lab_test.reference_ranges.blank?
      range_max = lab_test.reference_ranges.for_its_gender(accession.patient.gender).for_its_age(accession.patient_age).first.max
      format_value(range_max)
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
    if lab_test.ratio || lab_test.range || lab_test.fraction || lab_test.text_length
      "normal_value"
    else
      check_range
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

  def format_value(number)
    ApplicationController.helpers.number_with_precision(number, :precision => lab_test.decimals, :delimiter => ',')
  end

  def check_range
    if formatted_value == "pend."
      "normal_value"
    elsif range_max && range_min
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
      "normal_value"
    end
  end
end
