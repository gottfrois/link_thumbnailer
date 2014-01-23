module LinkThumbnailer

  module ImgComparator

    def <=> other
      if other.size != nil && size != nil
        return (other.size.min ** 2) <=> (size.min ** 2)
      elsif other.size != nil
        return 1
      else
        return -1
      end
    end

  end

end
