Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['3221c7661e241b9f41bc'], ENV['7e4704cb95dad84db4654e32da9f6383b922b870']
end