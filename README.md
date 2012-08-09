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

TODO

	$ rails g link_thumbnailer:install

## Usage

In `irb`:

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

	LinkThumbnailer.setup do |config|
		# Set mandatory attributes require for the website to be valid.
		# You can set `strict` to false if you want to skip this validation.
		# config.mandatory_attributes = %w(url title image)
		
		# Whether you want to validate given website against mandatory attributes or not.
		# config.strict = false
	end
	

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
