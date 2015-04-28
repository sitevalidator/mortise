require "mortise/version"
require "mortise/checker"
require "mortise/issue"
require "mortise/errors"

module Mortise
  TENON_APP_ID = '490866e2ad3b501842cef0569e4c0ee0'

  def self.check(url, key, options = {})
    Mortise::Checker.new(url, key, options)
  end
end
