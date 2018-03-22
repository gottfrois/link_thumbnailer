# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Response do
  let(:url) { 'https://www.google.co.jp' }
  let(:page) { ::LinkThumbnailer::Page.new(url, {}) }

  let(:response) do
    r = ::Net::HTTPSuccess.new('', 200, body_shift_jis)
    r['Content-Type'] = 'text/html'
    r.body = body_shift_jis
    r.instance_variable_set(:@read, true)
    r
  end

  let(:instance) { described_class.new(response) }

  let(:body_shift_jis) do
    File.read(File.expand_path('fixtures/google_shift_jis.html', File.dirname(__FILE__)))
  end

  let(:body_utf8) do
    File.read(File.expand_path('fixtures/google_utf8.html', File.dirname(__FILE__)))
  end

  before do
    allow(LinkThumbnailer).to receive(:page).and_return(page)
  end

  describe '#charset' do
    context 'when charset provided in content-type' do
      before do
        response['Content-Type'] = 'text/html; charset=Shift_JIS'
      end

      it { expect(instance.charset).to eq 'Shift_JIS' }
    end

    context 'when no charset available in content-type' do
      it { expect(instance.charset).to eq '' }
    end
  end

  describe '#body' do
    context 'when provide valid charset' do
      before do
        response['Content-Type'] = 'text/html; charset=Shift_JIS'
      end

      it { expect(instance.body).to eq body_utf8 }
    end

    context 'when provide invalid charset' do
      before do
        response['Content-Type'] = 'text/html; charset=Shift-JIS'
      end

      it { expect(instance.body).to eq body_shift_jis }
    end
  end
end
