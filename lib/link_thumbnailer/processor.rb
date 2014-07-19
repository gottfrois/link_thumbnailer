require 'delegate'
require 'uri'
require 'net/http/persistent'

module LinkThumbnailer
  class Processor < ::SimpleDelegator

    attr_accessor :url
    attr_reader   :config, :http, :redirect_count

    def initialize
      @config = ::LinkThumbnailer.page.config
      @http   = ::Net::HTTP::Persistent.new

      super(config)
    end

    def call(url = '', redirect_count = 0)
      self.url        = url
      @redirect_count = redirect_count

      raise ::LinkThumbnailer::RedirectLimit if too_many_redirections?

      with_valid_url do
        set_http_headers
        set_http_options
        perform_request
      end
    end

    private

    def with_valid_url
      raise ::LinkThumbnailer::BadUriFormat unless valid_url_format?
      yield if block_given?
    end

    def set_http_headers
      http.headers['User-Agent']               = user_agent
      http.override_headers['Accept-Encoding'] = 'none'
    end

    def set_http_options
      http.verify_mode  = ::OpenSSL::SSL::VERIFY_NONE unless ssl_required?
      http.open_timeout = http_timeout
    end

    def perform_request
      response = http.request(url)
      case response
      when ::Net::HTTPSuccess then response.body
      when ::Net::HTTPRedirection
        call resolve_relative_url(response['location']), redirect_count + 1
      else
        response.error!
      end
    end

    def resolve_relative_url(location)
      location.start_with?('http') ? location : build_absolute_url_for(location)
    end

    def build_absolute_url_for(relative_url)
      URI("#{url.scheme}://#{url.host}#{relative_url}")
    end

    def redirect_limit
      config.redirect_limit
    end

    def user_agent
      config.user_agent
    end

    def http_timeout
      config.http_timeout
    end

    def ssl_required?
      config.verify_ssl
    end

    def too_many_redirections?
      redirect_count > redirect_limit
    end

    def valid_url_format?
      url.is_a?(::URI::HTTP)
    end

    def url=(url)
      @url = ::URI.parse(url.to_s)
    end

  end
end
