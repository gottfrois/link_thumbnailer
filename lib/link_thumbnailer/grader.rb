require 'delegate'
require 'link_thumbnailer/graders/base'
require 'link_thumbnailer/graders/length'
require 'link_thumbnailer/graders/html_attribute'
require 'link_thumbnailer/graders/link_density'

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
      graders.map do |lambda|
        instance = lambda.call(description)
        instance.call(score)
      end.inject(:+)
    end

    private

    def graders
      config.graders
    end

  end
end
