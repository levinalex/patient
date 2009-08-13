class AccessionPanel < ActiveRecord::Base
  belongs_to :accession
  belongs_to :lab_test_panel
end
