require 'httparty'
require 'json'

module Mortise
  class Checker
    attr_reader :url, :tenon_uri, :key, :tenon_app_id

    def initialize(url, key, options = {})
      options = defaults.merge(options)

      @url       = url
      @key       = key

      @tenon_uri    = options[:tenon_uri]
      @tenon_app_id = options[:tenon_app_id]
    end

    def raw
      @raw ||= JSON.parse response.body
    end

    def issues
      @issues ||= raw['resultSet'].map { |issue| Mortise::Issue.new(issue) }
    end

    def errors
      @errors ||= issues.select { |issue| issue.certainty >= 80 }
    end

    def warnings
      @warnings ||= issues.select { |issue| issue.certainty < 80 }
    end

    private

    def defaults
      { tenon_uri: 'https://tenon.io/api/', tenon_app_id: Mortise::TENON_APP_ID }
    end

    def response
      fail(ERRORS[tenon_response.code], tenon_response.body) if tenon_response.code != 200

      tenon_response
    end

    def tenon_response
      @tenon_response ||= HTTParty.post(tenon_uri, body: { url: url, key: key, appID: tenon_app_id },
                                                   headers: { 'Content-Type'  => 'application/x-www-form-urlencoded',
                                                              'Cache-Control' => 'no-cache' })
    end
  end
end
