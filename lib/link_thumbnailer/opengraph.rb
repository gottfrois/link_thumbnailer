module LinkThumbnailer
    class Opengraph

      def self.parse(object, doc)
        object[:images] = []
        doc.css('meta').each do |m|
          if m.attribute('property') && m.attribute('property').to_s.match(/^og:(.+)$/i)
            content = m.attribute('content').to_s
            object[:images] << { source_url: content } if $1 == 'image'
            object[$1.gsub('-', '_')] = content
          end
        end

        object
      end

    end
end
