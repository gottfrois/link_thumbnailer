require 'spec_helper'

describe LinkThumbnailer::Model do

  let(:instance) { described_class.new }

  describe '#sanitize' do

    let(:str)     { "foo\r\n" }
    let(:result)  { "foo" }
    let(:action)  { instance.send(:sanitize, str) }

    it { expect(action).to eq(result) }

  end

end
