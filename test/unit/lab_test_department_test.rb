require 'test_helper'

class LabTestDepartmentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert LabTestDepartment.new.valid?
  end
end
