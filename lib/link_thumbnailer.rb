require 'json'
require 'nokogiri'
require 'open-uri'
require 'hashie'
require 'link_thumbnailer/object'
require 'link_thumbnailer/parser/opengraph'
require 'link_thumbnailer/version'

module LinkThumbnailer
  mattr_accessor :mandatory_attributes
  @@mandatory_attributes = %w(url title image)

  mattr_accessor :strict
  @@strict = false

  def self.configure
    yield self
  end

  def self.url(url)
    parse(open(url), url)
  rescue
    false
  end

private

  def self.parse(source, url)
    doc = Nokogiri.parse(source.read)

    object = LinkThumbnailer::Object.new
    object[:url] = url

    object = Parser::Opengraph.parse(object, doc)
    return object unless object.nil?

    nil
  end

end
