require 'spec_helper'

describe LinkThumbnailer::VideoParser do

  let(:src)       { 'http://foo.com/foo.swf' }
  let(:video)     { double(src: src) }
  let(:parser)    { double('parser') }
  let(:instance)  { described_class.new(video) }

  before do
    instance.stub(:parser).and_return(parser)
  end

  describe '#id' do

    let(:action) { instance.id }

    context 'when respond to video_id' do

      before do
        parser.stub(:video_id).and_return(1)
      end

      it { expect(action).to eq(parser.video_id) }

    end

    context 'when do not respond to video_id' do

      before do
        parser.stub(:video_id).and_raise(NoMethodError)
      end

      it { expect(action).to be_nil }

    end

  end

  describe '#size' do

    let(:action) { instance.size }

    context 'when respond to width and height' do

      before do
        parser.stub(:width).and_return(1)
        parser.stub(:height).and_return(1)
      end

      it { expect(action).to eq([parser.width, parser.height]) }

    end

    context 'when do not respond to width and height' do

      before do
        parser.stub(:width).and_raise(NoMethodError)
        parser.stub(:height).and_raise(NoMethodError)
      end

      it { expect(action).to be_empty }

    end

  end

  describe '#duration' do

    let(:action) { instance.duration }

    context 'when respond to duration' do

      before do
        parser.stub(:duration).and_return(1)
      end

      it { expect(action).to eq(parser.duration) }

    end

    context 'when do not respond to duration' do

      before do
        parser.stub(:duration).and_raise(NoMethodError)
      end

      it { expect(action).to be_nil }

    end

  end

  describe '#provider' do

    let(:action) { instance.provider }

    context 'when respond to provider' do

      before do
        parser.stub(:provider).and_return(1)
      end

      it { expect(action).to eq(parser.provider) }

    end

    context 'when do not respond to provider' do

      before do
        parser.stub(:provider).and_raise(NoMethodError)
      end

      it { expect(action).to be_nil }

    end

  end

  describe '#embed_code' do

    let(:action) { instance.embed_code }

    context 'when respond to embed_code' do

      before do
        parser.stub(:embed_code).and_return('')
      end

      it { expect(action).to eq(parser.embed_code) }

    end

    context 'when do not respond to embed_code' do

      before do
        parser.stub(:embed_code).and_raise(NoMethodError)
      end

      it { expect(action).to be_nil }

    end

  end

end
