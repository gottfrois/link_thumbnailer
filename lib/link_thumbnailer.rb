require 'nokogiri'
require 'open-uri'
require 'hashie'
require 'link_thumbnailer/object'
require 'link_thumbnailer/version'

module LinkThumbnailer
  mattr_accessor :mendatory_attributes
  @@mandatory_attributes = %w(url title image)

  def self.setup
    yield self
  end

  def self.url(url)
    source = open(url).read
    doc = Nokogiri.parse(source)

    object = LinkThumbnailer::Object.new

    doc.css('meta').each do |m|
      if m.attributes('property') && m.attributes('property').to_s.match(/^og:(.+)$/i)
        object[$1.gsub('-', '_')] = m.attributes('content').to_s
      end
    end

    return object
  end

end
