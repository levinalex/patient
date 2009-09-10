namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    Patient.populate 5 do |patient|
      patient.given_name    = Faker::Name.first_name
      patient.middle_name   = Faker::Name.first_name
      patient.family_name   = Faker::Name.last_name
      patient.family_name2  = Faker::Name.last_name
      patient.gender        = [M, F]
      patient.birthdate     = 100.years.ago..Time.now
      patient.indentifier   = Faker::
      patient.email         = Faker::Internet.email
      patient.phone         = Faker::PhoneNumber.phone_number
      patient.street        = Faker::Address.street_address
    end
  end
end