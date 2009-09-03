class Panel < ActiveRecord::Base
  has_many :lab_test_panels
  has_many :lab_tests, :through => :lab_test_panels
  has_many :accession_panels
  has_many :accessions, :through => :accession_panels
  #translates :name
  
  def lab_test_code_list
    list = []
    lab_tests.each do |lab_test|
      list << lab_test.code
    end
    list.join(', ')
  end
end
