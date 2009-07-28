require 'test_helper'

class LabTestValueOptionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert LabTestValueOption.new.valid?
  end
end
