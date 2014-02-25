require 'link_thumbnailer/configuration'
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

  module Rails
    autoload :Routes, 'link_thumbnailer/rails/routes'
  end

  class << self

    attr_accessor :configuration, :object, :fetcher, :doc_parser,
                  :img_url_filters, :img_parser, :logger

    def logger
      @logger ||= ::Rails.logger
    end

    def config
      self.configuration ||= Configuration.new(
        mandatory_attributes: %w(url title images),
        strict:               true,
        redirect_limit:       3,
        blacklist_urls:       [
          %r{^http://ad\.doubleclick\.net/},
          %r{^http://b\.scorecardresearch\.com/},
          %r{^http://pixel\.quantserve\.com/},
          %r{^http://s7\.addthis\.com/}
        ],
        image_attributes:     %w(source_url size type),
        limit:                10,
        top:                  5,
        user_agent:           'linkthumbnailer',
        verify_ssl:           true,
        http_timeout:         5
      )
    end

    def configure
      yield config
    end

    def generate(url, options = {})
      set_options(options)
      instantiate_classes

      doc = doc_parser.parse(fetcher.fetch(url), url)

      self.object[:url] = fetcher.url.to_s
      opengraph(doc) || custom(doc)
    end

    private

    def set_options(options)
      config
      options.each {|k, v| config[k] = v }
    end

    def instantiate_classes
      self.object           = LinkThumbnailer::Object.new
      self.fetcher          = LinkThumbnailer::Fetcher.new
      self.doc_parser       = LinkThumbnailer::DocParser.new
      self.img_url_filters  = [LinkThumbnailer::ImgUrlFilter.new]
      self.img_parser       = LinkThumbnailer::ImgParser.new(fetcher, img_url_filters)
    end

    def opengraph(doc)
      return unless opengraph?(doc)
      self.object = LinkThumbnailer::Opengraph.parse(object, doc)
      return object if object.valid?
      nil
    end

    def custom(doc)
      self.object[:title]       = doc.title
      self.object[:description] = doc.description
      self.object[:images]      = img_parser.parse(doc.img_abs_urls.dup)
      self.object[:url]         = doc.canonical_url || object[:url]
      return object if object.valid?
      nil
    end

    def opengraph?(doc)
      !doc.xpath('//meta[starts-with(@property, "og:") and @content]').empty?
    end

  end

end

begin
  require 'rails'
rescue LoadError
end

$stderr.puts <<-EOC if !defined?(Rails)
warning: no framework detected.

Your Gemfile might not be configured properly.
---- e.g. ----
Rails:
    gem 'link_thumbnailer'

EOC

if defined?(Rails)
  require 'link_thumbnailer/engine'
  require 'link_thumbnailer/railtie'
end
