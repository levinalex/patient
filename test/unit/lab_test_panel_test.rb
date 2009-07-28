require 'test_helper'

class LabTestPanelTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert LabTestPanel.new.valid?
  end
end
