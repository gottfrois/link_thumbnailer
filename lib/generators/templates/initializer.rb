# Use this hook to configure LinkThumbnailer bahaviors.
LinkThumbnailer.configure do |config|
  # Numbers of redirects before raising an exception when trying to parse given url.
  #
  # config.redirect_limit = 3

  # Set user agent
  #
  # config.user_agent = 'link_thumbnailer'

  # Enable or disable SSL verification
  #
  # config.verify_ssl = true

  # HTTP open_timeout: The amount of time in seconds to wait for a connection to be opened.
  #
  # config.http_timeout = 5

  # List of blacklisted urls you want to skip when searching for images.
  #
  # config.blacklist_urls = [
  #   %r{^http://ad\.doubleclick\.net/},
  #   %r{^http://b\.scorecardresearch\.com/},
  #   %r{^http://pixel\.quantserve\.com/},
  #   %r{^http://s7\.addthis\.com/}
  # ]

  # List of attributes you want LinkThumbnailer to fetch on a website.
  #
  # config.attributes = [:title, :images, :description]

  # List of procedures used to rate the website description. Add you custom class
  # here. Note that the order matter to compute the score. See wiki for more details
  # on how to build your own graders.
  #
  # config.graders = [
  #   ->(config, desc) { ::LinkThumbnailer::Graders::Length.new(config, desc) },
  #   ->(config, desc) { ::LinkThumbnailer::Graders::HtmlAttribute.new(config, desc, :class) },
  #   ->(config, desc) { ::LinkThumbnailer::Graders::HtmlAttribute.new(config, desc, :id) },
  #   ->(config, desc) { ::LinkThumbnailer::Graders::LinkDensity.new(config, desc) }
  # ]

  # Minimum description length for a website.
  #
  # config.description_min_length = 25

  # Regex of words considered positive to rate website description.
  #
  # config.positive_regex = /article|body|content|entry|hentry|main|page|pagination|post|text|blog|story/i

  # Regex of words considered negative to rate website description.
  #
  # config.negative_regex = /combx|comment|com-|contact|foot|footer|footnote|masthead|media|meta|outbrain|promo|related|scroll|shoutbox|sidebar|sponsor|shopping|tags|tool|widget|modal/i
end
