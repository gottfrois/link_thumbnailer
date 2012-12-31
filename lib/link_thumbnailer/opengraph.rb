module LinkThumbnailer
    class Opengraph

      def self.parse(object, doc)
        doc.css('meta').each do |m|
          if m.attribute('property') && m.attribute('property').to_s.match(/^og:(.+)$/i)
            object[$1.gsub('-', '_')] = m.attribute('content').to_s
          end
        end

        object[:images] = []
        if object[:image]
          object[:images] << { :source_url => object[:image] }
        end

        object
      end

    end
end
