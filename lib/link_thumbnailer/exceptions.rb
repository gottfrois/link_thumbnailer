module LinkThumbnailer
  class Exceptions    < StandardError; end
  class RedirectLimit < Exceptions; end
  class BadUriFormat  < Exceptions; end
end
