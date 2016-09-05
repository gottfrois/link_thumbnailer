require 'delegate'
require 'uri'
require 'net/http/persistent'

module LinkThumbnailer
  class Processor < ::SimpleDelegator

    attr_accessor :url
    attr_reader   :config, :http, :redirect_count, :content_type

    def initialize
      @config = ::LinkThumbnailer.page.config
      @http   = ::Net::HTTP::Persistent.new

      super(config)
    end

    def call(url = '', redirect_count = 0, headers = {})
      self.url        = url
      @redirect_count = redirect_count

      raise ::LinkThumbnailer::RedirectLimit if too_many_redirections?

      with_valid_url do
        set_http_headers(headers)
        set_http_options
        perform_request
      end
    rescue ::Net::HTTPExceptions, ::SocketError, ::Timeout::Error => e
      raise ::LinkThumbnailer::HTTPError.new(e.message)
    end

    private

    def with_valid_url
      raise ::LinkThumbnailer::BadUriFormat unless valid_url_format?
      yield if block_given?
    end

    def set_http_headers(headers = {})
      headers.each { |k, v| http.headers[k] = v }
      http.override_headers['User-Agent']      = user_agent
      http.override_headers['Accept-Encoding'] = 'none'
    end

    def set_http_options
      http.verify_mode  = ::OpenSSL::SSL::VERIFY_NONE unless ssl_required?
      http.open_timeout = http_open_timeout
      http.read_timeout = http_read_timeout
      http.proxy = :ENV
    end

    def perform_request
      body = String.new
      response = http.request(url) do |resp|
        response = resp
        raise ::LinkThumbnailer::DownloadSizeLimit if too_big_download_size?(resp.header['content-length'])
        resp.read_body do |chunk|
          body += chunk
          raise ::LinkThumbnailer::DownloadSizeLimit if too_big_download_size?(body.length)
        end
      end

      headers           = {}
      headers['Cookie'] = response['Set-Cookie'] if response['Set-Cookie'].present?

      raise ::LinkThumbnailer::FormatNotSupported.new(response['Content-Type']) unless valid_response_format?(response)

      case response
      when ::Net::HTTPSuccess
        body
      when ::Net::HTTPRedirection
        call(
          resolve_relative_url(response['location'].to_s),
          redirect_count + 1,
          headers
        )
      else
        response.error!
      end
    end

    def resolve_relative_url(location)
      location.start_with?('http') ? location : build_absolute_url_for(location)
    end

    def build_absolute_url_for(relative_url)
      ::URI.parse("#{url.scheme}://#{url.host}#{relative_url}")
    end

    def download_size_limit
      config.download_size_limit
    end

    def redirect_limit
      config.redirect_limit
    end

    def user_agent
      config.user_agent
    end

    def http_open_timeout
      config.http_open_timeout
    end

    def http_read_timeout
      config.http_read_timeout
    end

    def ssl_required?
      config.verify_ssl
    end

    def too_many_redirections?
      redirect_count > redirect_limit
    end

    def too_big_download_size?(size)
      download_size_limit && (size.to_i > download_size_limit)
    end

    def valid_url_format?
      url.is_a?(::URI::HTTP)
    end

    def valid_response_format?(response)
      if response['Content-Type'] =~ (/text\/html|application\/html|application\/xhtml\+xml|application\/xml|text\/xml|text\/plain/)
        @content_type=:application
        return true
      elsif response['Content-Type'] =~ /image\//
        @content_type=:image
        return true
      elsif response['Content-Type'] =~ /video\//
        @content_type=:video
        return tru
      end
      !config.raise_on_invalid_format
    end

    def url=(url)
      @url = ::URI.parse(url.to_s)
    end

  end
end
