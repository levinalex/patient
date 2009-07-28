require 'test_helper'

class LabTestResultTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert LabTestResult.new.valid?
  end
end
