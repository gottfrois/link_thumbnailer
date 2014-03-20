require 'link_thumbnailer/model'

module LinkThumbnailer
  module Models
    class Description < ::LinkThumbnailer::Model

      attr_reader :node, :text

      def initialize(node, text = nil)
        @node = node
        @text = sanitize(text || node.text)
      end

      private

      # def compute_score
      #   if text.length < config.min_description_length
      #     @score = -1
      #     return
      #   end

      #   @score -= text.split("\n").length
      #   @score += text.split(',').length

      #   @score += [(text.length / 100).to_i, 3].min
      #   @score += compute_class_score
      #   @score += compute_id_score

      #   parent.score += score if parent
      #   parent.parent.score += score / 2.0 if parent && parent.parent

      #   @score *= (1 - link_density)
      # end

      # def compute_class_score
      #   return 0 unless node[:class] && !node[:class].empty?

      #   score = 0
      #   score -= 25 if node[:class] =~ negative_name_regex
      #   score += 25 if node[:class] =~ positive_name_regex
      #   score
      # end

      # def compute_id_score
      #   return 0 unless node[:id] && !node[:id].empty?

      #   score = 0
      #   score -= 25 if node[:id] =~ negative_name_regex
      #   score += 25 if node[:id] =~ positive_name_regex
      #   score
      # end

      # def link_density
      #   links.length / text.length.to_f
      # end

      # def links
      #   node.css('a').map(&:text).join
      # end

      # def negative_name_regex
      #   /combx|comment|com-|contact|foot|footer|footnote|masthead|media|meta|outbrain|promo|related|scroll|shoutbox|sidebar|sponsor|shopping|tags|tool|widget|modal/i
      # end

      # def positive_name_regex
      #   /article|body|content|entry|hentry|main|page|pagination|post|text|blog|story/i
      # end

    end
  end
end
