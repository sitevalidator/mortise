module Mortise
  class Error < StandardError
  end

  class BadRequestError < Error
  end

  class UnauthorizedError < Error
  end

  class InternalServerError < Error
  end

  class ConnectionTimeOutError < Error
  end

  ERRORS = {
    400 => BadRequestError,
    401 => UnauthorizedError,
    500 => InternalServerError,
    522 => ConnectionTimeOutError
  }
end
