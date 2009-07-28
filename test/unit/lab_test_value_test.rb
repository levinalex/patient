require 'test_helper'

class LabTestValueTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert LabTestValue.new.valid?
  end
end
