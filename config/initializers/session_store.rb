# Be sure to restart your server when you modify this file.

if Rails.env.production?
  ManifesteSe::Application.config.session_store :cookie_store, key: '_meurio_accounts_session', domain: 'meurio.org.br', expire_after: 1.minute
else
  ManifesteSe::Application.config.session_store :cookie_store, key: '_meurio_accounts_session'
end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# ManifesteSe::Application.config.session_store :active_record_store
