# frozen_string_literal: true

module LinkThumbnailer

  # Access point for the gem configurations.
  #
  # @return [LinkThumbnailer::Configuration] a configuration instance.
  def self.config
    @config ||= Configuration.new
  end

  # Configure hook used in the gem initializer. Convinient way to set all the
  # gem configurations.
  #
  # @example inside config/initializers/link_thumbnaler.rb
  #   LinkThumbnailer.configure do |config|
  #     config.user_agent = 'link_thumbnailer'
  #   end
  #
  # @return [void]
  def self.configure
    yield config if block_given?
  end

	class Configuration

    attr_accessor :redirect_limit, :blacklist_urls, :user_agent,
                  :verify_ssl, :http_open_timeout, :http_read_timeout, :attributes,
                  :graders, :description_min_length, :positive_regex, :negative_regex,
                  :image_limit, :image_stats, :raise_on_invalid_format, :max_concurrency,
                  :scrapers, :http_override_headers, :encoding

    alias_method :http_timeout, :http_open_timeout
    alias_method :http_timeout=, :http_open_timeout=

    # Create a new instance.
    #
    # @return [LinkThumbnailer::Configuration]
    def initialize
      @redirect_limit         = 3
      @user_agent             = 'link_thumbnailer'
      @verify_ssl             = true
      @http_open_timeout      = 5
      @http_read_timeout      = 5
      @blacklist_urls         = [
        %r{^http://ad\.doubleclick\.net/},
        %r{^http://b\.scorecardresearch\.com/},
        %r{^http://pixel\.quantserve\.com/},
        %r{^http://s7\.addthis\.com/}
      ]
      @attributes             = [:title, :images, :description, :videos, :favicon]
      @graders                = [
        ->(description) { ::LinkThumbnailer::Graders::Length.new(description) },
        ->(description) { ::LinkThumbnailer::Graders::HtmlAttribute.new(description, :class) },
        ->(description) { ::LinkThumbnailer::Graders::HtmlAttribute.new(description, :id) },
        ->(description) { ::LinkThumbnailer::Graders::Position.new(description, weigth: 3) },
        ->(description) { ::LinkThumbnailer::Graders::LinkDensity.new(description) },
      ]
      @description_min_length = 50
      @positive_regex = /article|body|content|entry|hentry|main|page|pagination|post|text|blog|story/i
      @negative_regex = /combx|comment|com-|contact|foot|footer|footnote|masthead|media|meta|outbrain|promo|related|scroll|shoutbox|sidebar|sponsor|shopping|tags|tool|widget|modal/i
      @image_limit    = 5
      @image_stats    = true
      @raise_on_invalid_format = false
      @max_concurrency = 20
      @scrapers = [:opengraph, :default]
      @http_override_headers = { 'Accept-Encoding' => 'none' }
      @encoding = 'utf-8'
    end

	end
end
