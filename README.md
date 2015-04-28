# Mortise [![travis build status](https://secure.travis-ci.org/sitevalidator/mortise.png?branch=master)](http://travis-ci.org/sitevalidator/mortise) [![Code Climate](https://codeclimate.com/github/sitevalidator/mortise/badges/gpa.svg)](https://codeclimate.com/github/sitevalidator/mortise) [![Dependency Status](https://gemnasium.com/sitevalidator/mortise.png)](https://gemnasium.com/sitevalidator/mortise)

Mortise is a Ruby client for the [Tenon.io](http://tenon.io/documentation/) accessibility checker. It lets you easily check for accessibility issues on web pages.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mortise'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mortise

## Usage

You'll need an API Key to use Tenon.io, so first [register](http://tenon.io/register.php) and come back when you've got your API Key.

To check accessibility on a web page, just pass Mortise the URL to check and the API key, like this:

```ruby
checker = Mortise.check('http://validationhell.com', 'YOUR-API-KEY')
```

Then, you can check the JSON response like this:

```ruby
checker.raw # {
            #   "resultSet":[
            #     {
            #       "bpID":1,
            #       "certainty":100,
            #       "errorDescription":"All images must have an alt attribute...
```

Every issue returned will also accessible in a more friendly way like this, where the
snake_cased Ruby attributes correspond to the camelCased JSON attributes:

```ruby
issue = checker.issues.first

issue.bp_id
issue.certainty
issue.error_description
issue.error_snippet
issue.error_title
issue.position
issue.priority
issue.result_title
issue.signature
issue.standards
issue.t_id
issue.xpath
```

The `issues` array contains all issues returned by the checker, but you'll typically be more interested in `errors` (that contains all issues with certainty >= 80) and `warnings` (that contains all issues with certainty < 80).

## Using a Tenon Enterprise instance

By default, Mortise will query the Tenon.io API at http://tenon.io/api/ but if you're using your own Tenon Enterprise instance you can set its location like this:

```ruby
Mortise.check('http://example.com', 'YOUR-API-KEY', tenon_uri: 'http://yourchecker.com')
```

## Specifying a different Tenon App ID

By default, Mortise will pass its own identifier on the `appID` parameter, so that Tenon can keep usage stats for Mortise.

If you want to use a different value, you can override it like this:

```ruby
Mortise.check('http://example.com', 'YOUR-API-KEY', tenon_app_id: 'your-app-id')
```

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `bundle console` for an interactive prompt that will allow you to experiment.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mortise/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
