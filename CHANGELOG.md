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
