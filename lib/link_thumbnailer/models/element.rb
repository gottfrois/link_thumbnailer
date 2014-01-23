module LinkThumbnailer
  module Models
    class Element

      attr_reader :value, :tag

      def initialize(value, tag = nil)
        @value  = value
        @tag    = tag
      end

      def tag
        self['tag'].to_sym
      end

    end
  end
end
