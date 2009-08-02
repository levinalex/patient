class LabTestNormalRange < ActiveRecord::Base

  GENDER_TYPES = [
    #Displayed  stored in db
    [ "Both",     "*" ],
    [ "Female",   "F" ],
    [ "Male",     "M" ],
    [ "Unknown",  "U" ]
  ]

  belongs_to :lab_test
  named_scope :for_its_gender, lambda { |gender| { :conditions => { :gender => [gender, "*"] } } }
  # Missing age component (i.e. take into account age units, no newborns for now)
  named_scope :for_its_age, lambda { |age| { :conditions => ["min_age < ? AND max_age > ? OR min_age IS NULL OR max_age IS NULL", age, age] } }

  validates_inclusion_of :gender, :in => GENDER_TYPES.map {|disp, value| value}
end
