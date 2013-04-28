require 'net/http/persistent'

module LinkThumbnailer

  class Fetcher

    attr_accessor :url

    def fetch(url, redirect_count = 0)
      if redirect_count > LinkThumbnailer.configuration.redirect_limit
        raise ArgumentError,
          "too many redirects (#{redirect_count})"
      end

      self.url = url.is_a?(URI) ? url : URI(url)

      if self.url.is_a?(URI::HTTP)
        http = Net::HTTP::Persistent.new('linkthumbnailer')
        http.headers['User-Agent'] = LinkThumbnailer.configuration.user_agent
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE if not LinkThumbnailer.configuration.verify_ssl
        resp = http.request(self.url)
        case resp
          when Net::HTTPSuccess; resp.body
          when Net::HTTPRedirection; fetch(resp['location'], redirect_count + 1)
          else resp.error!
        end
      end
    end

  end

end
