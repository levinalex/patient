class LabTestNormalRange < ActiveRecord::Base

  GENDER_TYPES = [
    #Displayed  stored in db
    [ "Both",     "*" ],
    [ "Female",   "F" ],
    [ "Male",     "M" ],
    [ "Unknown",  "U" ]
  ]

  belongs_to :lab_test
  named_scope :females, :conditions => { :gender => ["F", "*"] }
  named_scope :males, :conditions => { :gender => ["M", "*"] }

  validates_inclusion_of :gender, :in => GENDER_TYPES.map {|disp, value| value}
end
