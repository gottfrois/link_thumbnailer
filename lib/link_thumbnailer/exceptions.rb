module LinkThumbnailer
  class Exceptions      < StandardError; end
  class RedirectLimit   < Exceptions; end
  class BadUriFormat    < Exceptions; end
  class FormatNotSupported < Exceptions; end
  class ScraperInvalid  < Exceptions; end
end
