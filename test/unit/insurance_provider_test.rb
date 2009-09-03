require 'test_helper'

class InsuranceProviderTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert InsuranceProvider.new.valid?
  end
end
