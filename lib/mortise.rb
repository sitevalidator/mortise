require "mortise/version"
require "mortise/checker"
require "mortise/issue"
require "mortise/errors"

module Mortise
  def self.check(url, key, options = {})
    Mortise::Checker.new(url, key, options)
  end
end
