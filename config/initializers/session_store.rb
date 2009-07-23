# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_payment_session',
  :secret      => '832a478cac12e136d95e29198fbf136e6fbf17908ba09b35f210cdcbaba747e6cad4de0ce0eb03cca289a11016e79de8e8d8b536064bb6f2902303825e24f1d9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
