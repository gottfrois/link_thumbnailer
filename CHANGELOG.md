# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.4.0]
### Adds

- Adds `download_size_limit` configuration to raise `LinkThumbnailer::DownloadSizeLimit` when the body of the request is too big. Defaults to `10 * 1024 * 1024` bytes.
- Adds `favicon_size` configuration to allow to choose which favison
size the gem should prefer. Defaults to the first favicon found otherwise.

### Fixes

- Fixes string encoding in previous versions of Ruby
- Fixes favicon by providing the full path.
- When HTML charset cannot be found in the HTML header, we now try
to find it in the body.
- Closes the HTTP connection upon completion

### Changes

- 401 HTTP errors now raise `LinkThumbnailer::HTTPError`
- Upgrades [ImageInfo](https://github.com/gottfrois/image_info/blob/master/CHANGELOG.md) gem

## [3.3.2]
### Fixes

- Frozen strings https://github.com/gottfrois/link_thumbnailer/pull/125

## [3.3.1]
### Changes

- Gem upgrade (json)

## [3.3.0]
### Adds

- Allows to configure overrided http headers

```ruby
LinkThumbnailer.configure do |config|
  config.http_override_headers = { 'Accept-Encoding' => 'none', ... }
end
```

## [3.2.1]
### Fixes

- Fixes #88
- Override User-Agent header properly
- Match xpath nodes if attribute content is present
- Avoid nil urls in image parser

## [3.2.0]
### Adds

Makes scrapers configurable by allowing to set the scraping strategy:

```ruby
LinkThumbnailer.configure do |config|
  config.scrapers = [:opengraph, :default]
end
```

`opengraph` use the [Open Graph Protocol](http://ogp.me/).
`default` use a homemade algorithm

## [3.1.2]
### Adds

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

## [3.1.1]
### Fixes

- Fixes https://github.com/gottfrois/link_thumbnailer/issues/69

### Changes

- Upgrade `video_info` gem

## [3.1.0]
### Fixes

- Fix an issue when image sizes could not be retrieved.

### Adds

- Grapers now accepts an optional parameter to customize the weigth of the grader in the probablity computation.

```ruby
LinkThumbnailer::Graders::Position.new(description, weigth: 3)
```

Will give a 3 times more weigth to the `Position` grader compare to other graders.
By default all graders have a weigth of `1` except the above position grader since position should play a bigger role in
order to find good description candidates.

## [3.0.3]
### Fixes

- Fix an issue when dealing with absolute urls. https://github.com/gottfrois/link_thumbnailer/issues/68
- Fix an issue with http redirection and location header not beeing present. https://github.com/gottfrois/link_thumbnailer/issues/70
- Rescue and raise custom LinkThumbnailer exceptions. https://github.com/gottfrois/link_thumbnailer/issues/71

## [3.0.2]
### Fixes

- Replace FastImage gem dependency by [ImageInfo](https://github.com/gottfrois/image_info) to improve performances when
fetching multiple images size information. Benchmark shows an order of magnitude improvement response time.
- Fixes [#57](https://github.com/gottfrois/link_thumbnailer/issues/57)

## [3.0.1]
### Fixes

- Remove useless dependencies

## [3.0.0]
### Changes

- Improved description sorting.
- Refactored how graders work. More information [here](https://github.com/gottfrois/link_thumbnailer/wiki/How-to-build-your-own-Grader%3F)

## [2.6.1]
### Fixes

- Fix remove useless dependency

## [2.6.0]
### Adds

- Introduce new `raise_on_invalid_format` option (false by default) to raise `LinkThumbnailer::FormatNotSupported` if http `Content-Type` is invalid. Fixes #61 and #64.

## [2.5.2]
### Fixes

- Fix OpenURI::HTTPError exception raised when video_info gem is not able to parse video metadata. Fixes #60.

## [2.5.1]
### Adds

- Implement `Set-Cookie` header between http redirections to set cookies when site requires it. Fixes #55.

## [2.5.0]
### Adds

- Handles seamlessly `og:image` and `og:image:url`
- Handles seamlessly `og:video` and `og:video:url`
- Handles `og:video:width` and `og:video:height` for one video only (please create a ticket if you want support for multiple videos/images width & height)

### Fixes

- Fix calling `as_json` on `website` to return `as_json` representation of videos and images, not just their urls

### Changes

- Gem updates

## [2.4.0]
### Adds

- Handle connection through proxy automatically using the `ENV['HTTP_PROXY']` variable thanks to [taganaka](https://github.com/taganaka).

## [2.3.2]
### Fixes

- Fix an issue with vimeo opengraph urls. Fixes [#46](https://github.com/gottfrois/link_thumbnailer/pull/46)

## [2.3.1]
### Fixes

- Fix an issue with the link density grader caused by links with image instead of text. Fixes [#45](https://github.com/gottfrois/link_thumbnailer/issues/45)

## [2.3.0]
### Adds

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

## [2.2.3]
### Fixes

- Fixes [#41](https://github.com/gottfrois/link_thumbnailer/issues/41)

## [2.2.2]
### Fixes

- Fixes [#41](https://github.com/gottfrois/link_thumbnailer/issues/41)

## [2.2.1]
### Fixes

- Fixes issue when computing link density ratio

## [2.2.0]
### Adds

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

## [2.1.0]
### Adds

- Increased `og:image` scraping performance by parsing `og:image:width` and `og:image:height` attribute if specified
- Introduced `image_stats` option to allow disabling image size and type parsing causing performance issues.

When disabled, size will be `[0, 0]` and type will be `nil`

## [2.0.4]
### Fixes

- Fixes [#39](https://github.com/gottfrois/link_thumbnailer/issues/39)

## [2.0.3]
### Fixes

- Fixes [#37](https://github.com/gottfrois/link_thumbnailer/issues/37)

## [2.0.2]
### Fixes

- Fixes couple of issues with `URI` class namespace

## [2.0.1]

- Fixes issue with image parser (fastimage) when given an URI instance instead of a string

## [2.0.0]
### Changes

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

## [1.1.2]
### Fixes

- Fixes issue with FastImage URLs [https://github.com/gottfrois/link_thumbnailer/pull/31](https://github.com/gottfrois/link_thumbnailer/pull/31)

## [1.1.1]
### Fixes

- Fixes route helper not working under rails 4.

## [1.1.0]
### Changes

- Replace RMagick by [FastImage](https://github.com/sdsykes/fastimage)
- Rename `rmagick_attributes` config into `image_attributes`

## [1.0.9]
### Fixes

- Fixes issue when Location header used a relative path instead of an absolute path

### Changes

- Update gemfile to be more flexible when using Hashie gem

## [1.0.8]
# Adds

- Thanks to [juriglx](https://github.com/juriglx), support for canonical urls

### Fixes

- Bug fixes

## [1.0.7]
### Fixes

- Fixes an issue with the preview controller

## [1.0.6]
### Fixes

- Fixes an issue when setting `strict` option. Always returning OG representation.

## [1.0.5]
### Adds

- Thanks to [phlegx](https://github.com/phlegx), support for timeout http connection through configurations.

## [1.0.4]
### Fixes

- Fixes issue #7: nil img was returned when exception is raised. Now skiping nil images in results.

### Adds

- Thanks to [phlegx](https://github.com/phlegx), support for SSL and User Agent customization through configurations.

## [1.0.3]
### Fixes

- Fixes issue #5: Url was incorect in case of HTTP Redirections.

## [1.0.2]
### Fixes

- Bug fix when doing ```rails g link_thumbnailer:install``` by explicitly specifying the scope of Rails

### Adds

- User can now set options at runtime by passing valid options to ```generate``` method

## [1.0.1]
### Fixes

- Refactor LinkThumbnailer#generate method to have a cleaner code

## [1.0.0]
### Changes

- Update readme
- Add PreviewController for easy integration with user's app
- Add link_thumbnailer routes for easy integration with user's app
- Refactor some code
- Change 'to_a' method to 'to_hash' in object model

## [0.0.6]
### Adds

- Update readme
- Add `to_a` to WebImage class
- Add specs corresponding

### Fixes

- Refactor `to_json` for WebImage class

## [0.0.5]
### Fixes

- Bug fix
- Remove `require 'rails'` from spec_helper.rb
- Remove rails dependences (blank? method) in code
- Spec fix

## [0.0.4]
### Adds

- Add specs for almost all classes
- Add a method `to_json` for WebImage class to be able to get a usable array of images' attributes

## [0.0.3]
### Adds

- Add specs for LinkThumbnailer class

### Fixes

- Refactor config system, now using dedicated configuration class

## [0.0.2]
### Adds

- Added Rspec

### Fixes

- Now checking if attribute is blank for LinkThumbnailer::Object.valid? method

## [0.0.1]
### Adds

- First release 🎆

[Unreleased]: https://github.com/gottfrois/link_thumbnailer/compare/v3.4.0...HEAD
[3.4.0]: https://github.com/gottfrois/link_thumbnailer/compare/v3.3.2...v3.4.0
[3.3.2]: https://github.com/gottfrois/link_thumbnailer/compare/v3.3.1...v3.3.2
[3.3.1]: https://github.com/gottfrois/link_thumbnailer/compare/v3.3.0...v3.3.1
[3.3.0]: https://github.com/gottfrois/link_thumbnailer/compare/v3.2.1...v3.3.0
[3.2.1]: https://github.com/gottfrois/link_thumbnailer/compare/v3.2.0...v3.2.1
[3.2.0]: https://github.com/gottfrois/link_thumbnailer/compare/v3.1.2...v3.2.0
[3.1.2]: https://github.com/gottfrois/link_thumbnailer/compare/v3.1.1...v3.1.2
[3.1.1]: https://github.com/gottfrois/link_thumbnailer/compare/v3.1.0...v3.1.1
[3.1.0]: https://github.com/gottfrois/link_thumbnailer/compare/v3.0.3...v3.1.0
[3.0.3]: https://github.com/gottfrois/link_thumbnailer/compare/v3.0.2...v3.0.3
[3.0.2]: https://github.com/gottfrois/link_thumbnailer/compare/v3.0.1...v3.0.2
[3.0.1]: https://github.com/gottfrois/link_thumbnailer/compare/v3.0.0...v3.0.1
[3.0.0]: https://github.com/gottfrois/link_thumbnailer/compare/v2.6.1...v3.0.0
[2.6.1]: https://github.com/gottfrois/link_thumbnailer/compare/v2.6.0...v2.6.1
[2.6.0]: https://github.com/gottfrois/link_thumbnailer/compare/v2.5.2...v2.6.0
[2.5.2]: https://github.com/gottfrois/link_thumbnailer/compare/v2.5.1...v2.5.2
[2.5.1]: https://github.com/gottfrois/link_thumbnailer/compare/v2.5.0...v2.5.1
[2.5.0]: https://github.com/gottfrois/link_thumbnailer/compare/v2.4.0...v2.5.0
[2.4.0]: https://github.com/gottfrois/link_thumbnailer/compare/v2.3.2...v2.4.0
[2.3.2]: https://github.com/gottfrois/link_thumbnailer/compare/v2.3.1...v2.3.2
[2.3.1]: https://github.com/gottfrois/link_thumbnailer/compare/v2.3.0...v2.3.1
[2.3.0]: https://github.com/gottfrois/link_thumbnailer/compare/v2.2.3...v2.3.0
[2.2.3]: https://github.com/gottfrois/link_thumbnailer/compare/v2.2.2...v2.2.3
[2.2.2]: https://github.com/gottfrois/link_thumbnailer/compare/v2.2.1...v2.2.2
[2.2.1]: https://github.com/gottfrois/link_thumbnailer/compare/v2.2.0...v2.2.1
[2.2.0]: https://github.com/gottfrois/link_thumbnailer/compare/v2.1.0...v2.2.0
[2.1.0]: https://github.com/gottfrois/link_thumbnailer/compare/v2.0.4...v2.1.0
[2.0.4]: https://github.com/gottfrois/link_thumbnailer/compare/v2.0.3...v2.0.4
[2.0.3]: https://github.com/gottfrois/link_thumbnailer/compare/v2.0.2...v2.0.3
[2.0.2]: https://github.com/gottfrois/link_thumbnailer/compare/v2.0.1...v2.0.2
[2.0.1]: https://github.com/gottfrois/link_thumbnailer/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/gottfrois/link_thumbnailer/compare/v1.1.2...v2.0.0
[1.1.2]: https://github.com/gottfrois/link_thumbnailer/compare/v1.1.1...v1.1.2
[1.1.1]: https://github.com/gottfrois/link_thumbnailer/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/gottfrois/link_thumbnailer/compare/v1.0.9...v1.1.0
[1.0.9]: https://github.com/gottfrois/link_thumbnailer/compare/v1.0.8...v1.0.9
[1.0.8]: https://github.com/gottfrois/link_thumbnailer/compare/v1.0.7...v1.0.8
[1.0.7]: https://github.com/gottfrois/link_thumbnailer/compare/v1.0.6...v1.0.7
[1.0.6]: https://github.com/gottfrois/link_thumbnailer/compare/v1.0.5...v1.0.6
[1.0.5]: https://github.com/gottfrois/link_thumbnailer/compare/v1.0.4...v1.0.5
[1.0.4]: https://github.com/gottfrois/link_thumbnailer/compare/v1.0.3...v1.0.4
[1.0.3]: https://github.com/gottfrois/link_thumbnailer/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/gottfrois/link_thumbnailer/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/gottfrois/link_thumbnailer/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/gottfrois/link_thumbnailer/compare/v0.0.6...v1.0.0
[0.0.6]: https://github.com/gottfrois/link_thumbnailer/compare/v0.0.5...v0.0.6
[0.0.5]: https://github.com/gottfrois/link_thumbnailer/compare/v0.0.4...v0.0.5
[0.0.4]: https://github.com/gottfrois/link_thumbnailer/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/gottfrois/link_thumbnailer/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/gottfrois/link_thumbnailer/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/gottfrois/link_thumbnailer/releases/tag/v0.0.1
