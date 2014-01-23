module LinkThumbnailer

  # Access point for the gem configurations.
  #
  # @return [LinkThumbnailer::Configuration] a configuration instance.
  def self.config
    @configuration ||= Configuration.new
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

    attr_accessor :redirect_limit, :blacklist_urls, :user_agent, :verify_ssl,
                  :http_timeout, :scrapers

    # Create a new instance.
    #
    # @return [LinkThumbnailer::Configuration]
    def initialize
      @redirect_limit = 3
      @user_agent     = 'link_thumbnailer'
      @verify_ssl     = true
      @http_timeout   = 5
      @blacklist_urls = [
        %r{^http://ad\.doubleclick\.net/},
        %r{^http://b\.scorecardresearch\.com/},
        %r{^http://pixel\.quantserve\.com/},
        %r{^http://s7\.addthis\.com/}
      ]
      @scrapers       = [:opengraph, :text]
    end

	end
end
