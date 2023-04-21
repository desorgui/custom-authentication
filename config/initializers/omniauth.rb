Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer if Rails.env.development?
  provider :github, '3221c7661e241b9f41bc', '892bad090cc3eed9cff46ee38ee59e904d76a4b3'
  provider :facebook, '1549955355529189', '4bf7b6d97a0df3ca087fb1607950de97'
  provider :google_oauth2, '256391844390-9v3pqh4e979ulutel43dc58il1n7ugt0.apps.googleusercontent.com', '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'
end