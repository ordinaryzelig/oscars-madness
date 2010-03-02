# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_oscars-madness_session',
  :secret      => '82ec9b08697a126927fc1557b80a143550c8bb3d041981fb68e8cf35d44f46dda0e8d685b95561b84df3518d0634110c331bc11dc85ae7946db88f8d3a38f36f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
