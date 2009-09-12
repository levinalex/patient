class Patient < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  GENDERS = [
    #Displayed  stored in db
    [ I18n.translate('patients.female'),  "F" ],
    [ I18n.translate('patients.male'),    "M" ],
    [ I18n.translate('patients.unknown'), "U" ]
  ]

  TYPES = [
    #Displayed  stored in db
    [ I18n.translate('patients.canine'),   "1" ],
    [ I18n.translate('patients.feline'),   "2" ],
    [ I18n.translate('patients.dialysis'), "3" ]
  ]

  attr_accessible :given_name, :middle_name, :family_name, :family_name2, :gender, :birthdate, :identifier, :email, :phone, :address, :type, :insurance_provider_id
  
  validates_presence_of :given_name, :family_name, :gender, :birthdate
  validates_inclusion_of :gender, :in => GENDERS.map {|disp, value| value}
  validates_uniqueness_of :identifier, :allow_blank => true
  
  belongs_to :insurance_provider
  has_many :accessions, :dependent => :destroy
  accepts_nested_attributes_for :accessions, :allow_destroy => true
  
  named_scope :recent, :order => 'updated_at DESC', :limit => 10
  
  before_save :capitalize_names

  # Meanwhile... use thinking sphinx with delta instead
  def self.search(query, page)
    paginate :per_page => 10, :page => page, :conditions => ['given_name LIKE ? OR middle_name LIKE ? OR family_name LIKE ? OR family_name2 LIKE ? OR identifier LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"], :order => 'family_name ASC'
  end
  
  def full_name
    [given_name, middle_name, family_name, family_name2].join(' ').squeeze(' ').strip
  end
  memoize :full_name
  
  def age
    # Age reported should be calculated based on reported_at when reported
    days_per_year = 365.25
    age = ((Date.today - birthdate.to_date).to_i / days_per_year).floor
  end
  memoize :age
  
  def age_in_months
    months = Date.today.month - birthdate.month
    age * 12 + months
  end
  
  def gender_name
    case gender
    when "F"
      I18n.translate('patients.female')
    when "M"
      I18n.translate('patients.male')
    when "U"
      I18n.translate('patients.unknown')
    end
  end
  
  def validate
    errors.add(:birthdate, "cannot be in the future") if birthdate > Date.today unless birthdate.nil?
  end
  
  private

  ##
  # Must be extended to capitalize international characters (á, é ...)
  def capitalize_names
    self.given_name = given_name.capitalize if given_name
    self.middle_name = middle_name.capitalize if middle_name
    self.family_name = family_name.capitalize if family_name
    self.family_name2 = family_name2.capitalize if family_name2
  end
end
