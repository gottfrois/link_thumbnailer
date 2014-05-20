require 'json'
require 'link_thumbnailer/version'
require 'link_thumbnailer/configuration'
require 'link_thumbnailer/exceptions'
require 'link_thumbnailer/page'

module LinkThumbnailer

  class << self

    attr_reader :page

    def generate(url, options = {})
      @page = ::LinkThumbnailer::Page.new(url, options)

      page.generate
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
