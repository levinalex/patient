class Patient < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  GENDER_TYPES = [
    #Displayed  stored in db
    [ "Female",  "F" ],
    [ "Male",    "M" ],
    [ "Unknown", "U" ]
  ]
  
  attr_accessible :given_name, :middle_name, :family_name, :family_name2, :gender, :birthdate, :identifier, :address
  
  validates_presence_of :given_name, :family_name, :gender, :birthdate
  validates_inclusion_of :gender, :in => GENDER_TYPES.map {|disp, value| value}
  validates_uniqueness_of :identifier, :allow_blank => true
  
  has_many :accessions, :dependent => :destroy
  accepts_nested_attributes_for :accessions, :allow_destroy => true
  
  def self.search(query)
    if query
      find(:all, :conditions => ['given_name LIKE ?', "%#{query}%"])
    else
      find(:all)
    end
  end
  
  def full_name
    [given_name, middle_name, family_name, family_name2].join(' ')
  end
  memoize :full_name
  
  def age
    # Age reported should be calculated based on Today = Reported at
    days_per_year = 365.25
    age = ((Date.today - birthdate.to_date).to_i / days_per_year).floor
  end
  memoize :age
  
  def age_in_months
    months = Date.today.month - birthdate.month
    age * 12 + months
  end
    
  def validate
    errors.add(:birthdate, "cannot be in the future") if birthdate > Date.today unless birthdate.nil?
  end
  
end
