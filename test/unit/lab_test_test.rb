require 'test_helper'

class LabTestTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert LabTest.new.valid?
  end
end
