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

Run `irb` and then:

	require 'rails'
	 => true
	require 'link_thumbnailer'
	 => true
	
	object = LinkThumbnailer.url('http://example.com/')
	=> #<LinkThumbnailer::Object description="some description" image="http://example.com/icon.png" site_name="example.com" title="Join us at example.com">

	object.title?
 	=> true
 	object.title
 	=> "Join us at example.com"

 	object.url?
	=> true
	object.url
	=> "http://example.com"

	object.foo?
	=> false
	object.foo
	=> nil


You can check whether this object is valid or not (set mandatory attributes in the initializer, defaults are `[url, title, image]`)

	object.valid?
 	=> true

## Configuration

In `config/initializers/link_thumbnailer.rb`

	LinkThumbnailer.configure do |config|
		# Set mandatory attributes require for the website to be valid.
		# You can set `strict` to false if you want to skip this validation.
		# config.mandatory_attributes = %w(url title image)

		# Whether you want to validate given website against mandatory attributes or not.
		# config.strict = true
	end

## Features

Implemented:

- Implements [OpenGraph](http://ogp.me/) protocol

Coming soon:

- Implementing [oEmbed](http://oembed.com/) protocol
- Implementing a finder to get all of the images according to how well they represent what the page is about (including relative images).
- Sort images based on their size and color
- Blacklist some well known image urls
- Cache results on filesystem

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
