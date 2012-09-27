require 'link_thumbnailer/config'
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

  class << self

    attr_accessor :configuration, :object, :fetcher, :doc_parser,
                  :img_url_filters, :img_parser

    def config
      self.configuration ||= Configuration.new(
        :mandatory_attributes => %w(url title images),
        :strict               => true,
        :redirect_limit       => 3,
        :blacklist_urls       => [
          %r{^http://ad\.doubleclick\.net/},
          %r{^http://b\.scorecardresearch\.com/},
          %r{^http://pixel\.quantserve\.com/},
          %r{^http://s7\.addthis\.com/}
        ],
        :limit                => 10,
        :top                  => 5
      )
    end

    def configure
      yield config
    end

    def generate(url, options = {})
      LinkThumbnailer.configure {|config|
        config.top          = options[:top].to_i    if options[:top]
        config.limit        = options[:limit].to_i  if options[:limit]
      }

      self.object           = LinkThumbnailer::Object.new
      self.fetcher          = LinkThumbnailer::Fetcher.new
      self.doc_parser       = LinkThumbnailer::DocParser.new

      doc_string = self.fetcher.fetch(url)
      doc = self.doc_parser.parse(doc_string, url)

      self.object[:url] = doc.source_url

      # Try Opengraph first
      self.object = LinkThumbnailer::Opengraph.parse(self.object, doc)
      return self.object if self.object.valid?

      # Else try manually
      self.img_url_filters  = [LinkThumbnailer::ImgUrlFilter.new]
      self.img_parser       = LinkThumbnailer::ImgParser.new(self.fetcher, self.img_url_filters)

      self.object[:title] = doc.title
      self.object[:description] = doc.description
      self.object[:images] = self.img_parser.parse(doc.img_abs_urls.dup)

      return nil unless self.object.valid?
      self.object
    end

  end

end
