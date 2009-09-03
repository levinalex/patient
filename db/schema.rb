# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090903062648) do

  create_table "accession_panels", :force => true do |t|
    t.integer  "accession_id"
    t.integer  "panel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accessions", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "other_id"
    t.integer  "labels"
    t.datetime "drawn_at"
    t.integer  "drawn_by"
    t.integer  "specimen_type_id"
    t.datetime "received_at"
    t.integer  "received_by"
    t.boolean  "stat"
    t.text     "note"
    t.decimal  "diagnosis"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "reported_at"
    t.integer  "reported_by"
    t.integer  "doctor_id"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
  end

  create_table "insurance_providers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lab_test_absurd_ranges", :force => true do |t|
    t.decimal  "min"
    t.decimal  "max"
    t.string   "gender"
    t.integer  "min_age"
    t.integer  "max_age"
    t.string   "age_unit"
    t.integer  "lab_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lab_test_critical_ranges", :force => true do |t|
    t.decimal  "min"
    t.decimal  "max"
    t.string   "gender"
    t.integer  "min_age"
    t.integer  "max_age"
    t.string   "age_unit"
    t.integer  "lab_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lab_test_linear_ranges", :force => true do |t|
    t.decimal  "min"
    t.decimal  "max"
    t.string   "gender"
    t.integer  "min_age"
    t.integer  "max_age"
    t.string   "age_unit"
    t.integer  "lab_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lab_test_normal_ranges", :force => true do |t|
    t.decimal  "min"
    t.decimal  "max"
    t.string   "gender"
    t.integer  "min_age"
    t.integer  "max_age"
    t.string   "age_unit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lab_test_id"
  end

  create_table "lab_test_panels", :force => true do |t|
    t.integer  "lab_test_id"
    t.integer  "panel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lab_test_value_option_joints", :force => true do |t|
    t.integer  "lab_test_value_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lab_test_id"
  end

  create_table "lab_test_value_options", :force => true do |t|
    t.boolean  "numeric"
    t.boolean  "ratio"
    t.boolean  "range"
    t.boolean  "fraction"
    t.integer  "text_length"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lab_test_id"
  end

  create_table "lab_test_values", :force => true do |t|
    t.string   "value"
    t.string   "flag"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lab_tests", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.integer  "decimals"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.integer  "unit_id"
    t.integer  "procedure"
    t.boolean  "derivation"
    t.boolean  "also_numeric"
    t.boolean  "ratio"
    t.boolean  "range"
    t.boolean  "fraction"
    t.integer  "text_length"
    t.integer  "position"
  end

  create_table "panels", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", :force => true do |t|
    t.string   "given_name"
    t.string   "middle_name"
    t.string   "family_name"
    t.string   "family_name2"
    t.string   "gender"
    t.date     "birthdate"
    t.string   "identifier"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type"
    t.integer  "insurance_provider_id"
  end

  create_table "results", :force => true do |t|
    t.string   "value"
    t.integer  "lab_test_id"
    t.integer  "accession_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lab_test_value_id"
  end

  create_table "units", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password",  :null => false
    t.string   "password_salt",     :null => false
    t.string   "persistence_token", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "initials"
    t.string   "language"
    t.string   "name_to_display"
  end

end
