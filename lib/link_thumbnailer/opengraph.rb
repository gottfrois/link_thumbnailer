module LinkThumbnailer
    class Opengraph

      def self.parse(object, doc)
        doc.css('meta').each do |m|
          if m.attribute('property') && m.attribute('property').to_s.match(/^og:(.+)$/i)
            object[$1.gsub('-', '_')] = m.attribute('content').to_s
          end
        end
        object[:images] = [object[:image]] if object[:image]

        object
      end

    end
end
