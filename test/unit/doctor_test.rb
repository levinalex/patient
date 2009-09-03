require 'test_helper'

class DoctorTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Doctor.new.valid?
  end
end
