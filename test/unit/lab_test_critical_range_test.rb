require 'test_helper'

class LabTestCriticalRangeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert LabTestCriticalRange.new.valid?
  end
end
