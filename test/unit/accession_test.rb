require 'test_helper'

class AccessionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Accession.new.valid?
  end
end
