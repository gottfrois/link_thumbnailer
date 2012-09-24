require 'net/http/persistent'

module LinkThumbnailer

  class Fetcher

    def fetch(url, redirect_count = 0)
      if redirect_count > LinkThumbnailer.configuration.redirect_limit
        raise ArgumentError,
          "too many redirects (#{redirect_count})"
      end

      uri = url.is_a?(URI) ? url : URI(url)

      if uri.is_a?(URI::HTTP)
        http = Net::HTTP::Persistent.new('linkthumbnailer')
        http.headers['User-Agent'] = 'linkthumbnailer'
        resp = http.request(uri)
        case resp
          when Net::HTTPSuccess; resp.body
          when Net::HTTPRedirection; fetch(resp['location'], redirect_count + 1)
          else resp.error!
        end
      end
    end

  end

end
