# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_patient_session',
  :secret      => 'ab8ec183212eed8c4b58aa54d95d67c7c92ed6279df1af8f42b91c9bc661f49c0c294a6f5ea61ed5b4ea4b8c5b0d38424fe4ea6ba36a8b49d6a6150424f45af8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
