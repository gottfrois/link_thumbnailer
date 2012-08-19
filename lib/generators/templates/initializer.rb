# Use this hook to configure LinkThumbnailer bahaviors.
LinkThumbnailer.configure do |config|
  # Set mandatory attributes require for the website to be valid.
  # You can set `strict` to false if you want to skip this validation.
  # config.mandatory_attributes = %w(url title image)

  # Whether you want to validate given website against mandatory attributes or not.
  # config.strict = true

  # Numbers of redirects before raising an exception when trying to parse given url.
  # config.redirect_limit = 3

  # List of blacklisted urls you want to skip when searching for images.
  # config.blacklist_urls = [
  #   %r{^http://ad\.doubleclick\.net/},
  #   %r{^http://b\.scorecardresearch\.com/},
  #   %r{^http://pixel\.quantserve\.com/},
  #   %r{^http://s7\.addthis\.com/}
  # ]

  # Fetch 10 images maximum.
  # config.max = 10

  # Return top 5 images only.
  # config.top = 5
end
