require 'test_helper'

class LabTestNormalRangeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert LabTestNormalRange.new.valid?
  end
end
