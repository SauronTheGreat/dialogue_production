# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Dialogue v1.0_session',
  :secret      => 'de5ed0fe51547b1eeab090383b0f21fd5e7be76123f059b7d2923f2f92ab2e0f9d1a41da77bc025494a61fa5fd0ead006dd5d49f4678d7858bcd2385b01d2293'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
