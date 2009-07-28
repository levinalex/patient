class LabTestPanelJoint < ActiveRecord::Base
  belongs_to :lab_test
  belongs_to :lab_test_panel
end
