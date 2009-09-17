class ReferenceRange < ActiveRecord::Base
# Unify Normal, Critical, Absurd and Linear ranges into one table.

  GENDERS = [
    #Displayed  stored in db
    [ "Both",     "*" ],
    [ "Female",   "F" ],
    [ "Male",     "M" ],
    [ "Unknown",  "U" ]
  ]

  AGE_UNITS = [
    #Displayed  stored in db
    [ "Years",    "Y" ],
    [ "Months",   "M" ],
    [ "Days",     "D" ],
    [ "Hours",    "H" ]
  ]

  belongs_to :lab_test
  named_scope :for_its_gender, lambda { |gender| { :conditions => { :gender => [gender, "*"] } } }
  # TODO: Missing age component (i.e. take into account age units, no newborns for now)
  named_scope :for_its_age, lambda { |age| { :conditions => ["min_age <= ? AND max_age > ? OR (min_age IS NULL AND max_age IS NULL) OR (min_age <= ? AND max_age IS NULL)", age, age, age] } }
  # TODO: named_scope :human :joins => :patient, :type => human

  validates_inclusion_of :gender, :in => GENDERS.map {|disp, value| value}
end
