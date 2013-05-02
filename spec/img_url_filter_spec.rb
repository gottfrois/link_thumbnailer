require 'spec_helper'

describe LinkThumbnailer::ImgUrlFilter do

  it { should respond_to :reject? }

  describe ".reject?" do

    let(:img_url_filter) { LinkThumbnailer::ImgUrlFilter.new }

    before do
      LinkThumbnailer.configure {|config| config.blacklist_urls = [
        %r{^http://not_valid\.net/}
      ]}
    end

    context "when img_url does not contain any blacklisted urls" do

      it { expect(img_url_filter.reject?('http://valid.com/foo/bar.png')).to be_false }

    end

    context "when img_url does contain any blacklisted urls" do

      it { expect(img_url_filter.reject?('http://not_valid.net/foo/bar.png')).to be_true }

    end

  end

end
