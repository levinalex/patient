require 'test_helper'

class LabTestLinearRangeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert LabTestLinearRange.new.valid?
  end
end
