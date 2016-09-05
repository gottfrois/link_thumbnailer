uri = ::URI.parse('http://trailers.divx.com/divx_prod/profiles/WiegelesHeliSki_DivXPlus_19Mbps.mkv')
body = String.new()
i = 0 
Net::HTTP.start(uri.host, uri.port) do |http|
  request = Net::HTTP::Get.new uri

  http.request request do |response|
  	puts response.header['content-length']
    open 'large_file', 'w' do |io|
      response.read_body do |chunk|
        body += chunk
        i += 1
        puts i
        raise 'Too much' if body.length > 3.kilobytes 
      end
    end
  end
end


http   = ::Net::HTTP::Persistent.new
uri = ::URI.parse('http://trailers.divx.com/divx_prod/profiles/WiegelesHeliSki_DivXPlus_19Mbps.mkv')
response = nil

http.request(uri) do |resp|
  response = resp
  puts resp.header['content-length']
    resp.read_body do |chunk|
      response.body += chunk
      raise 'Too much' if body.length > 3.kilobytes 
    end
  end
end

http   = ::Net::HTTP::Persistent.new
url = ::URI.parse('http://example.com/')
body = String.new
response = Net::HTTPResponse.new
i = 0 

resp = http.request(uri)