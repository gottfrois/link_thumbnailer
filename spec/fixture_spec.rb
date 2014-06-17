require 'spec_helper'

describe 'Fixture' do

  let(:url)         { 'http://foo.com' }
  let(:png_url)     { 'http://foo.com/foo.png' }
  let(:video_url)   { 'http://foo.com/foo.swf' }
  let(:png)         { File.open(File.dirname(__FILE__) + '/fixtures/foo.png') }
  let(:action)      { LinkThumbnailer.generate(url) }

  before do
    stub_request(:get, url).to_return(status: 200, body: html, headers: {})
    stub_request(:get, png_url).to_return(status: 200, body: png, headers: {})
  end

  describe 'Opengraph' do

    let(:title)       { 'Title from og' }
    let(:description) { 'Description from og' }

    context 'when valid' do

      let(:html) { File.open(File.dirname(__FILE__) + '/fixtures/og_valid_example.html').read() }

      it { expect(action.title).to                  eq(title) }
      it { expect(action.description).to            eq(description) }
      it { expect(action.images.count).to           eq(1) }
      it { expect(action.images.first.src.to_s).to  eq(png_url) }
      it { expect(action.images.first.size).to      eq([100, 100]) }
      it { expect(action.videos.count).to           eq(1) }
      it { expect(action.videos.first.src.to_s).to  eq(video_url) }

    end

    context 'with multi image' do

      let(:png_url_2) { 'http://foo.com/bar.png' }
      let(:png_2)     { File.open(File.dirname(__FILE__) + '/fixtures/bar.png') }
      let(:html)      { File.open(File.dirname(__FILE__) + '/fixtures/og_valid_multi_image_example.html').read() }

      before do
        stub_request(:get, png_url_2).to_return(status: 200, body: png_2, headers: {})
      end

      it { expect(action.title).to                  eq(title) }
      it { expect(action.description).to            eq(description) }
      it { expect(action.images.count).to           eq(2) }
      it { expect(action.images.first.src.to_s).to  eq(png_url) }
      it { expect(action.images.last.src.to_s).to   eq(png_url_2) }

    end

    context 'with multi video' do

      let(:video_url_2) { 'http://foo.com/bar.swf' }
      let(:html)        { File.open(File.dirname(__FILE__) + '/fixtures/og_valid_multi_video_example.html').read() }

      it { expect(action.title).to                  eq(title) }
      it { expect(action.description).to            eq(description) }
      it { expect(action.videos.count).to           eq(2) }
      it { expect(action.videos.first.src.to_s).to  eq(video_url) }
      it { expect(action.videos.last.src.to_s).to   eq(video_url_2) }

    end

    context 'when not valid' do

      let(:html) { File.open(File.dirname(__FILE__) + '/fixtures/og_not_valid_example.html').read() }

      it { expect(action.title).to                  eq(title) }
      it { expect(action.description).to            eq(description) }
      it { expect(action.images.count).to           eq(1) }
      it { expect(action.images.first.src.to_s).to  eq(png_url) }

    end

  end

  describe 'Default' do

    context 'from meta' do

      let(:html)        { File.open(File.dirname(__FILE__) + '/fixtures/default_from_meta.html').read() }
      let(:title)       { 'Title from meta' }
      let(:description) { 'Description from meta' }

      it { expect(action.title).to        eq(title) }
      it { expect(action.description).to  eq(description) }

    end

    context 'from body' do

      let(:html)        { File.open(File.dirname(__FILE__) + '/fixtures/default_from_body.html').read() }
      let(:description) { 'Description from body' }

      it { expect(action.description).to            eq(description) }
      it { expect(action.images.count).to           eq(1) }
      it { expect(action.images.first.src.to_s).to  eq(png_url) }

    end

  end

end
