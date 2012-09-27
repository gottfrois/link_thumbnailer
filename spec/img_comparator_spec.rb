require 'spec_helper'

describe LinkThumbnailer::ImgComparator do

  class Foo
  end

  let(:foo) { Foo.new }

  before do
    foo.extend(LinkThumbnailer::ImgComparator)
  end

  it { should respond_to :<=> }

end
