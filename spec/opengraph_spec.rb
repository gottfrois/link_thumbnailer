require 'spec_helper'

describe LinkThumbnailer::Opengraph do

  it { LinkThumbnailer::Opengraph.should respond_to(:parse).with(2).arguments }

end
