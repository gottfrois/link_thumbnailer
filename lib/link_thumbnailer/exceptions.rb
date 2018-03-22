# frozen_string_literal: true

module LinkThumbnailer
  Exceptions         = Class.new(StandardError)
  RedirectLimit      = Class.new(Exceptions)
  BadUriFormat       = Class.new(Exceptions)
  FormatNotSupported = Class.new(Exceptions)
  ScraperInvalid     = Class.new(Exceptions)
  HTTPError          = Class.new(Exceptions)
  SyntaxError        = Class.new(Exceptions)
end
