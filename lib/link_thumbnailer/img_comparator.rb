module LinkThumbnailer

  module ImgComparator

    def <=> other
      result = ([other.rows, other.columns].min ** 2) <=>
        ([rows, columns].min ** 2)

      if result == 0
        result = other.number_colors <=> number_colors
      end

      result
    end

  end

end
