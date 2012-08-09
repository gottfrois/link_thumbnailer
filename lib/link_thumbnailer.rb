require 'nokogiri'
require 'open-uri'
require 'hashie'
require 'link_thumbnailer/object'
require 'link_thumbnailer/version'

module LinkThumbnailer
  mattr_accessor :mandatory_attributes
  @@mandatory_attributes = %w(url title image)

  mattr_accessor :strict
  @@strict = true

  def self.setup
    yield self
  end

  def self.url(url)
    parse(open(url).read)
  rescue
    false
  end

private

  def self.parse(source)
    doc = Nokogiri.parse(source)

    object = LinkThumbnailer::Object.new

    doc.css('meta').each do |m|
      if m.attribute('property') && m.attribute('property').to_s.match(/^og:(.+)$/i)
        object[$1.gsub('-', '_')] = m.attribute('content').to_s
      end
    end

    return false if object.keys.empty?
    return false unless object.valid? if @@strict
    object
  end

end
