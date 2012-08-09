module LinkThumbnailer
  class Object < Hashie::Mash

    def valid?
      @@mandatory_attributes.each {|a| return false unless self[a] }
      true
    end

  end
end
