require 'delegate'
require 'link_thumbnailer/graders/base'
require 'link_thumbnailer/graders/length'
require 'link_thumbnailer/graders/html_attribute'
require 'link_thumbnailer/graders/link_density'
require 'link_thumbnailer/graders/position'

module LinkThumbnailer
  class Grader < ::SimpleDelegator

    attr_reader :config, :description

    def initialize(description)
      @config      = ::LinkThumbnailer.page.config
      @description = description

      super(config)
    end

    def call
      score = 0
      graders.each do |lambda|
        instance = lambda.call(description)
        score += instance.call(score)
      end

      score
    end

    private

    def graders
      config.graders
    end

  end
end
