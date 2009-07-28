require 'test_helper'

class LabTestAbsurdRangeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert LabTestAbsurdRange.new.valid?
  end
end
