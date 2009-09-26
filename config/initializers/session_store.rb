# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pcp_session',
  :secret      => '5aa8b51704bb5e7126aff215b86795ffc646d1eaf88d5e4b7258446afea530c88d0c88aba7864f5bb6f51087367ddb97a342ff49980cfb971cbd33df9c4d6f56'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
