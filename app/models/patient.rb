class Patient < ActiveRecord::Base

  GENDER_TYPES = [
    #Displayed  stored in db
    [ "Female",  "F" ],
    [ "Male",    "M" ],
    [ "Unknown", "U" ]
  ]
  
  attr_accessible :given_name, :middle_name, :family_name, :family_name2, :gender, :birthdate, :identifier, :address
  
  validates_presence_of :given_name, :family_name, :gender, :birthdate
  validates_inclusion_of :gender, :in => GENDER_TYPES.map {|disp, value| value}
  
  has_many :accessions, :dependent => :destroy
  
  def full_name
    [given_name, middle_name, family_name, family_name2].join(' ')
  end
  
  def age
    days_per_year = 365.25
    age = ((Date.today - birthdate.to_date).to_i / days_per_year).floor
  end
  
  def age_in_months
    months = Date.today.month - birthdate.month
    age * 12 + months
  end
    
  def validate
    errors.add(:birthdate, "cannot be in the future") if birthdate > Date.today unless birthdate.nil?
  end
  
end
