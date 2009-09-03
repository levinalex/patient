class Doctor < ActiveRecord::Base
  attr_accessible :name
  has_many :accessions, :dependent => :destroy
end
