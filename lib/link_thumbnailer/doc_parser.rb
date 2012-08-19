require 'nokogiri'

module LinkThumbnailer

  class DocParser

    def parse(doc_string, source_url = nil)
      doc = Nokogiri::HTML(doc_string).extend(LinkThumbnailer::Doc)
      doc.source_url = source_url
      doc
    end

  end

end
