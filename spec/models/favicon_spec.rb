# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Models::Favicon do

  let(:uri)       { URI.parse('http://foo.com') }
  let(:instance)  { described_class.new(uri) }

  it { expect(instance.to_s).to eq('http://foo.com') }

end
