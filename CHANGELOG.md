# 3.3.2

- Frozen strings https://github.com/gottfrois/link_thumbnailer/pull/125

# 3.3.1

- Gem upgrade (json)

# 3.3.0

- Allows to configure overrided http headers

```ruby
LinkThumbnailer.configure do |config|
  config.http_override_headers = { 'Accept-Encoding' => 'none', ... }
end
```

# 3.2.1

- Fixes #88
- Override User-Agent header properly
- Match xpath nodes if attribute content is present
- Avoid nil urls in image parser

# 3.2.0

Makes scrapers configurable by allowing to set the scraping strategy:

```ruby
LinkThumbnailer.configure do |config|
  config.scrapers = [:opengraph, :default]
end
```

`opengraph` use the [Open Graph Protocol](http://ogp.me/).
`default` use a homemade algorithm

# 3.1.2

Allows to customize ideal description length

Pass the :ideal_description_length option to the Graders::Length initializer to customize
the ideal description length of a website. In the rails initializer:

```ruby
LinkThumbnailer.configure do |config|
  config.graders = [
    ->(description) { ::LinkThumbnailer::Graders::Length.new(description, ideal_description_length: 500) },
    ->(description) { ::LinkThumbnailer::Graders::HtmlAttribute.new(description, :class) },
    ->(description) { ::LinkThumbnailer::Graders::HtmlAttribute.new(description, :id) },
    ->(description) { ::LinkThumbnailer::Graders::Position.new(description, weigth: 3) },
    ->(description) { ::LinkThumbnailer::Graders::LinkDensity.new(description) },
  ]
end
```

Will default to `120` characters. More information about how the gem manage to find the best description can be found at
http://www.codeids.com/2015/06/27/how-to-find-best-description-of-a-website-using-linkthumbnailer/

# 3.1.1

- Upgrade `video_info` gem
- Fixes https://github.com/gottfrois/link_thumbnailer/issues/69

# 3.1.0

- Fix an issue when image sizes could not be retrieved.
- Grapers now accepts an optional parameter to customize the weigth of the grader in the probablity computation.

```ruby
LinkThumbnailer::Graders::Position.new(description, weigth: 3)
```

Will give a 3 times more weigth to the `Position` grader compare to other graders.
By default all graders have a weigth of `1` except the above position grader since position should play a bigger role in
order to find good description candidates.

# 3.0.3

- Fix an issue when dealing with absolute urls. https://github.com/gottfrois/link_thumbnailer/issues/68
- Fix an issue with http redirection and location header not beeing present. https://github.com/gottfrois/link_thumbnailer/issues/70
- Rescue and raise custom LinkThumbnailer exceptions. https://github.com/gottfrois/link_thumbnailer/issues/71

# 3.0.2

- Replace FastImage gem dependency by [ImageInfo](https://github.com/gottfrois/image_info) to improve performances when
fetching multiple images size information. Benchmark shows an order of magnitude improvement response time.
- Fixes [#57](https://github.com/gottfrois/link_thumbnailer/issues/57)

# 3.0.1

- Remove useless dependencies

# 3.0.0

- Improved description sorting.
- Refactored how graders work. More information [here](https://github.com/gottfrois/link_thumbnailer/wiki/How-to-build-your-own-Grader%3F)

# 2.6.1

- Fix remove useless dependency

# 2.6.0

- Introduce new `raise_on_invalid_format` option (false by default) to raise `LinkThumbnailer::FormatNotSupported` if http `Content-Type` is invalid. Fixes #61 and #64.

# 2.5.2

- Fix OpenURI::HTTPError exception raised when video_info gem is not able to parse video metadata. Fixes #60.

# 2.5.1

- Implement `Set-Cookie` header between http redirections to set cookies when site requires it. Fixes #55.

# 2.5.0

- Handles seamlessly `og:image` and `og:image:url`
- Handles seamlessly `og:video` and `og:video:url`
- Handles `og:video:width` and `og:video:height` for one video only (please create a ticket if you want support for multiple videos/images width & height)
- Fix calling `as_json` on `website` to return `as_json` representation of videos and images, not just their urls
- Gem updates and fix rspec deprecation warnings

# 2.4.0

- Handle connection through proxy automatically using the `ENV['HTTP_PROXY']` variable thanks to [taganaka](https://github.com/taganaka).

# 2.3.2

- Fix an issue with vimeo opengraph urls. Fixes [#46](https://github.com/gottfrois/link_thumbnailer/pull/46)

# 2.3.1

- Fix an issue with the link density grader caused by links with image instead of text. Fixes [#45](https://github.com/gottfrois/link_thumbnailer/issues/45)

# 2.3.0

- Add requested favicon scraper [#40](https://github.com/gottfrois/link_thumbnailer/issues/40)

Add `:favicon` to `config.attributes` in LinkThumbnailer initializer:

```ruby
config.attributes = [:title, :images, :description, :videos, :favicon]
```

Then

```ruby
o = LinkThumbnailer.generate('https://github.com')
o.favicon
 => "https://github.com/fluidicon.png"
```

# 2.2.3

- Fixes [#41](https://github.com/gottfrois/link_thumbnailer/issues/41)

# 2.2.2

- Fixes [#41](https://github.com/gottfrois/link_thumbnailer/issues/41)

# 2.2.1

- Fix issue when computing link density ratio

# 2.2.0

- Add support for `og:video`
- Add support for multiple `og:video` as well

LinkThumbnailer will return the following json for example:

```ruby
{
  id:         'x7lni3',
  src:        'http://www.dailymotion.com/video/x7lni3',
  size:       [640, 360],
  duration:   136,
  provider:   'Dailymotion',
  embed_code: '<iframe src="//www.dailymotion.com/embed/video/x7lni3" frameborder="0" allowfullscreen="allowfullscreen"></iframe>'
}
```

Add `:videos` into your `config/initializers/link_thumbnailer.rb` `attributes` config in order to start scraping videos.

Ex:

```ruby
config.attributes = [:title, :images, :description, :videos]
```

# 2.1.0

- Increased `og:image` scraping performance by parsing `og:image:width` and `og:image:height` attribute if specified
- Introduced `image_stats` option to allow disabling image size and type parsing causing performance issues.

When disabled, size will be `[0, 0]` and type will be `nil`

# 2.0.4

- Fixes [#39](https://github.com/gottfrois/link_thumbnailer/issues/39)

# 2.0.3

- Fixes [#37](https://github.com/gottfrois/link_thumbnailer/issues/37)

# 2.0.2

- Fix couple of issues with `URI` class namespace

# 2.0.1

- Fix issue with image parser (fastimage) when given an URI instance instead of a string

# 2.0.0

- Fully refactored LinkThumbnailer
- Introduced [Graders](https://github.com/gottfrois/link_thumbnailer/wiki/How-to-build-your-own-Grader%3F)
- Introduced [Scrapers](https://github.com/gottfrois/link_thumbnailer/wiki/Attributes-option-explained)
- Ability to score descriptions
- Ability to fetch multiple `og:image`
- Fixed memoized run-time options
- Fixed some website urls not working
- Refactor ugly code
- More specs
- Removed `PreviewsController` since it does not add much value. Simply create your own and use the `to_json` method.

To update from `1.x.x` to `2.x.x` you need to run `rails g link_thumbnailer:install` to get the new configuration file.
If you used the `PreviewsController` feature, you need to build it yourself since it is not supported anymore.

# 1.1.2

- Fix issue with FastImage URLs [https://github.com/gottfrois/link_thumbnailer/pull/31](https://github.com/gottfrois/link_thumbnailer/pull/31)

# 1.1.1

- Fix route helper not working under rails 4.

# 1.1.0

- Replace RMagick by [FastImage](https://github.com/sdsykes/fastimage)
- Rename `rmagick_attributes` config into `image_attributes`

# 1.0.9

- Fix issue when Location header used a relative path instead of an absolute path
- Update gemfile to be more flexible when using Hashie gem

# 1.0.8

- Thanks to [juriglx](https://github.com/juriglx), support for canonical urls
- Bug fixes

# 1.0.7

- Fix: Issue with preview controller

# 1.0.6

- Fix: Issue when setting `strict` option. Always returning OG representation.

# 1.0.5

- Thanks to [phlegx](https://github.com/phlegx), support for timeout http connection through configurations.

# 1.0.4

- Fix issue #7: nil img was returned when exception is raised. Now skiping nil images in results.
- Thanks to [phlegx](https://github.com/phlegx), support for SSL and User Agent customization through configurations.

# 1.0.3

- Fix issue #5: Url was incorect in case of HTTP Redirections.

# 1.0.2

- Feature: User can now set options at runtime by passing valid options to ```generate``` method
- Bug fix when doing ```rails g link_thumbnailer:install``` by explicitly specifying the scope of Rails

# 1.0.1

- Refactor LinkThumbnailer#generate method to have a cleaner code

# 1.0.0

- Update readme
- Add PreviewController for easy integration with user's app
- Add link_thumbnailer routes for easy integration with user's app
- Refactor some code
- Change 'to_a' method to 'to_hash' in object model

# 0.0.6

- Update readme
- Add `to_a` to WebImage class
- Refactor `to_json` for WebImage class
- Add specs corresponding

# 0.0.5

- Bug fix
- Remove `require 'rails'` from spec_helper.rb
- Remove rails dependences (blank? method) in code
- Spec fix

# 0.0.4

- Add specs for almost all classes
- Add a method `to_json` for WebImage class to be able to get a usable array of images' attributes

# 0.0.3

- Add specs for LinkThumbnailer class
- Refactor config system, now using dedicated configuration class

# 0.0.2

- Added Rspec
- Bug fixes:
	- Now checking if attribute is blank for LinkThumbnailer::Object.valid? method

# 0.0.1

- LinkThumbnailer::Object
- LinkThumbnailer::Doc
- LinkThumbnailer::DocParser
- LinkThumbnailer::Fetcher
- LinkThumbnailer::ImgComparator
- LinkThumbnailer::ImgParser
- LinkThumbnailer::ImgUrlFilter
- LinkThumbnailer::Opengraph
- LinkThumbnailer::WebImage
- LinkThumbnailer.configure
- LinkThumbnailer.generate
