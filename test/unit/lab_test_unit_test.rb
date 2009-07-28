require 'test_helper'

class LabTestUnitTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert LabTestUnit.new.valid?
  end
end
