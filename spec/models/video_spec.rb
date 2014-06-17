require 'spec_helper'

describe LinkThumbnailer::Models::Video do

  let(:src)       { 'http://foo.com/foo.swf' }
  let(:instance)  { described_class.new(src) }

  describe '#to_s' do

    let(:action) { instance.to_s }

    it { expect(action).to eq(src) }

  end

  describe '#as_json' do

    let(:action)      { instance.as_json }
    let(:id)          { 1 }
    let(:size)        { [1, 1] }
    let(:duration)    { 10 }
    let(:provider)    { 'foo' }
    let(:embed_code)  { 'bar' }
    let(:result)      {
      {
        id:         id,
        src:        src,
        size:       size,
        duration:   duration,
        provider:   provider,
        embed_code: embed_code
      }
    }

    before do
      instance.stub(:id).and_return(id)
      instance.stub(:size).and_return(size)
      instance.stub(:duration).and_return(duration)
      instance.stub(:provider).and_return(provider)
      instance.stub(:embed_code).and_return(embed_code)
    end

    it { expect(action).to eq(result) }

  end

end
