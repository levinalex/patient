class LabTestNormalRange < ActiveRecord::Base
  GENDER_TYPES = [
    #Displayed  stored in db
    [ "Female",   "F" ],
    [ "Male",     "M" ],
    [ "Both",     "*" ],
    [ "Unknown",  "U" ]
  ]

  belongs_to :lab_test

  validates_inclusion_of :gender, :in => GENDER_TYPES.map {|disp, value| value}

end
