require "mortise/version"
require "mortise/checker"
require "mortise/issue"

module Mortise
  def self.check(url, key, options = {})
    Mortise::Checker.new(url, key, options)
  end
end
