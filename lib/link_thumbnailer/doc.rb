require 'uri'

module LinkThumbnailer

  module Doc

    def doc_base_href
      base = at('//head/base')
      base['href'] if base
    end

    def img_srcs
      search('//img').map { |i| i['src'] }.compact
    end

    def img_abs_urls(base_url = nil)
      result = []

      img_srcs.each do |i|
        begin
          u = URI(i)
        rescue URI::InvalidURIError
          next
        end

        result << if u.is_a?(URI::HTTP)
                    u
                  else
                    URI.join(base_url || doc_base_href || source_url, i)
                  end
      end

      result
    end

    def title
      css('title').text.strip
    end

    def description
      if element = xpath("//meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'description' and @content]").first
        return element.attributes['content'].value.strip
      end

      css('body p').each do |node|
        if !node.has_attribute?('style') && node.first_element_child.nil?
          return node.text.strip
        end
      end

      nil
    end

    attr_accessor :source_url

  end

end
