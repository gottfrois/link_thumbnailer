# -*- encoding : utf-8 -*-
# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Model do

  let(:instance) { described_class.new }

  describe '#sanitize' do

    let(:str)     { "foo\r\n" }
    let(:result)  { "foo" }
    let(:action)  { instance.send(:sanitize, str) }

    it { expect(action).to eq(result) }

    context "when string includes utf-8 characters" do
      let(:str) { "中文" }

      it "should keeps those characters" do
        expect(instance.send(:sanitize, str)).to eq(str)
      end
    end
  end

end
