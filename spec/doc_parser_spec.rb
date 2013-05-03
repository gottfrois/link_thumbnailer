require 'spec_helper'

describe LinkThumbnailer::DocParser do

  it { should respond_to(:parse).with(1).arguments }

  let(:instance) { LinkThumbnailer::DocParser.new }

  describe "#parse" do

    let(:source_url) { 'http://foo.com' }

    subject { instance.parse('', source_url) }

    it { expect(subject.source_url).to eq(source_url) }
    it { expect(subject).to respond_to(:doc_base_href) }
    it { expect(subject).to respond_to(:img_srcs) }
    it { expect(subject).to respond_to(:img_abs_urls) }
    it { expect(subject).to respond_to(:title) }
    it { expect(subject).to respond_to(:description) }
    it { expect(subject).to respond_to(:source_url) }

  end

end
