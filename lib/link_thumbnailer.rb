# require 'json'
# require 'nokogiri'
# require 'link_thumbnailer/parser/opengraph'

require 'link_thumbnailer/object'
require 'link_thumbnailer/fetcher'
require 'link_thumbnailer/doc_parser'
require 'link_thumbnailer/doc'
require 'link_thumbnailer/img_url_filter'
require 'link_thumbnailer/img_parser'
require 'link_thumbnailer/img_comparator'
require 'link_thumbnailer/web_image'

require 'link_thumbnailer/opengraph'

require 'link_thumbnailer/version'

module LinkThumbnailer

  mattr_accessor :mandatory_attributes
  @@mandatory_attributes = %w(url title images)

  mattr_accessor :strict
  @@strict = true

  mattr_accessor :redirect_limit
  @@redirect_limit = 3

  mattr_accessor :blacklist_urls
  @@blacklist_urls = [
    %r{^http://ad\.doubleclick\.net/},
    %r{^http://b\.scorecardresearch\.com/},
    %r{^http://pixel\.quantserve\.com/},
    %r{^http://s7\.addthis\.com/}
  ]

  mattr_accessor :max
  @@max = 10

  mattr_accessor :top
  @@top = 5

  def self.configure
    yield self
  end

  def self.generate(url, options = {})
    @@top = options[:top].to_i if options[:top]
    @@max = options[:max].to_i if options[:max]

    @object           = LinkThumbnailer::Object.new
    @fetcher          = LinkThumbnailer::Fetcher.new
    @doc_parser       = LinkThumbnailer::DocParser.new

    doc_string = @fetcher.fetch(url)
    doc = @doc_parser.parse(doc_string, url)

    @object[:url] = doc.source_url

    # Try Opengraph first
    @object = LinkThumbnailer::Opengraph.parse(@object, doc)
    return @object if @object.valid?

    # Else try manually
    @img_url_filters  = [LinkThumbnailer::ImgUrlFilter.new]
    @img_parser       = LinkThumbnailer::ImgParser.new(@fetcher, @img_url_filters)

    @object[:title] = doc.title
    @object[:description] = doc.description
    @object[:images] = @img_parser.parse(doc.img_abs_urls.dup)

    return nil unless @object.valid?
    @object
  end

end
