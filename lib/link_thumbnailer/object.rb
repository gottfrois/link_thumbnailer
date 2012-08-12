module LinkThumbnailer
  class Object < Hashie::Mash

    def method_missing(method_name, *args, &block)
      method_name = method_name.to_s

      if method_name.end_with?('?')
        method_name.chop!
        !self[method_name].nil?
      else
        self[method_name]
      end
    end

    def valid?
      return false if self.keys.delete_if {|x| x == 'url'}.empty?
      LinkThumbnailer.mandatory_attributes.each {|a| return false unless self[a] } if LinkThumbnailer.strict
      true
    end

  end
end
