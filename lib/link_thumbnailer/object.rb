require 'hashie'
require 'json'

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
      return false if keys.empty?
      LinkThumbnailer.configuration.mandatory_attributes.each { |a| return false if self[a].nil? || self[a].empty? } if LinkThumbnailer.configuration.strict
      true
    end

    def to_hash
      if images.none? { |i| i.is_a?(String) }
        super.merge('images' => images.map(&:to_hash))
      else
        super
      end
    end

    def to_json
      if images.none? { |i| i.is_a?(String) }
        JSON.generate(to_hash.merge('images' => images.map(&:to_hash)))
      else
        JSON.generate(to_hash)
      end
    end

  end
end
