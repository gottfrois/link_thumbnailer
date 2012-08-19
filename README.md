# LinkThumbnailer

Ruby gem generating image thumbnails from a given URL. Rank them and give you back an object containing images and website informations. Works like Facebook link previewer.

## Installation

Add this line to your application's Gemfile:

    gem 'link_thumbnailer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install link_thumbnailer

Run:

	$ rails g link_thumbnailer:install

This will add `link_thumbnailer.rb` to `config/initializers/`. See [#Configuration](https://github.com/gottfrois/link_thumbnailer#configuration) for more details.

## Usage

Run `irb` and require mandatory dependencies:

	require 'rails'
	 => true
	require 'link_thumbnailer'
	 => true
	 
This gem can handle [Opengraph](http://ogp.me/) protocol. Here is an example with such a website:
	
	object = LinkThumbnailer.generate('http://zerply.com')
	 => #<LinkThumbnailer::Object description="Go beyond the résumé - showcase your work and your talent" image="http://	zerply.com/img/front/facebook_icon_green.png" images=["http://zerply.com/img/front/facebook_icon_green.png"] 	site_name="zerply.com" title="Join Me on Zerply" url="http://zerply.com"> 

	object.title?
 	=> true
 	object.title
 	=> "Join Me on Zerply"

 	object.url?
	=> true
	object.url
	=> "http://zerply.com"

	object.foo?
	=> false
	object.foo
	=> nil

Now with a regular website with no particular protocol:

	object = LinkThumbnailer.generate('http://foo.com')
	 => #<LinkThumbnailer::Object description=nil images=[[ JPEG 750x200 750x200+0+0 DirectClass 8-bit 45kb]
	scene=0] title="Foo.com" url="http://foo.com"> 

	object.title
	 => "Foo.com"
	 
	object.images
	 => [[ JPEG 750x200 750x200+0+0 DirectClass 8-bit 45kb]
	scene=0]

	object.images.first.source_url
	 => #<URI::HTTP:0x007ff7a923ef58 URL:http://foo.com/media/	BAhbB1sHOgZmSSItMjAxMi8wNC8yNi8yMC8xMS80OS80MjYvY29yZG92YWJlYWNoLmpwZwY6BkVUWwg6BnA6CnRodW1iSSINNzUweDIwMCMGOwZU/	cordovabeach.jpg>

You can check whether this object is valid or not (set mandatory attributes in the initializer, defaults are `[url, title, images]`)

	object.valid?
 	=> true
 	
 You also can set `max` and `top` options at runtime:
 
 	object = LinkThumbnailer.generate('http://foo.com', :top => 10, :max => 20)

## Configuration

In `config/initializers/link_thumbnailer.rb`

	LinkThumbnailer.configure do |config|
	  # Set mandatory attributes require for the website to be valid.
	  # You can set `strict` to false if you want to skip this validation.
	  # config.mandatory_attributes = %w(url title image)

	  # Whether you want to validate given website against mandatory attributes or not.
	  # config.strict = true

	  # Numbers of redirects before raising an exception when trying to parse given url.
	  # config.redirect_limit = 3

	  # List of blacklisted urls you want to skip when searching for images.
	  # config.blacklist_urls = [
	  #   %r{^http://ad\.doubleclick\.net/},
	  #   %r{^http://b\.scorecardresearch\.com/},
	  #   %r{^http://pixel\.quantserve\.com/},
	  #   %r{^http://s7\.addthis\.com/}
	  # ]

	  # Fetch 10 images maximum.
	  # config.max = 10

	  # Return top 5 images only.
	  # config.top = 5
	end

## Features

Implemented:

- Implements [OpenGraph](http://ogp.me/) protocol.
- Find images and sort them according to how well they represent what the page is about (includes absolute images).
- Sort images based on their size and color.
- Blacklist some well known advertisings image urls.

Coming soon:

- Cache results on filesystem

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
