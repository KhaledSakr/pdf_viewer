Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1561929350784320', '1b6042d98a4761f4e2e1c5bcdc023a34'
end