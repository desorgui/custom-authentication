Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
  provider :github, ENV['3221c7661e241b9f41bc'], ENV['d4d3c5a76d56c24af0351fc6a78dceb32ac54e27']
end