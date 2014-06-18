require 'rack-cas/session_store/rails/active_record'

ManifesteSe::Application.config.session_store :rack_cas_active_record_store

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# ManifesteSe::Application.config.session_store :active_record_store
