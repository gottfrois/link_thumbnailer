require 'spec_helper'

describe LinkThumbnailer::Doc do

  class Foo
  end

  let(:foo) { Foo.new }

  before do
    foo.extend LinkThumbnailer::Doc
  end

  subject { foo }

  it { should respond_to :doc_base_href }
  it { should respond_to :img_srcs }
  it { should respond_to :img_abs_urls }
  it { should respond_to :title }
  it { should respond_to :description }
  it { should respond_to :source_url }

end
