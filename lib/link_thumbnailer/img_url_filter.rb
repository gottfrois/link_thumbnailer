module LinkThumbnailer

  class ImgUrlFilter

    def reject?(img_url)
      LinkThumbnailer.blacklist_urls.each do |url|
        return true if img_url && img_url.to_s[url]
      end
      false
    end

  end

end
