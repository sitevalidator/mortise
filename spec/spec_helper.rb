$: << File.join(File.dirname(__FILE__), "/../lib")

require 'mortise'
require 'webmock/rspec'

def fixture_file(filename)
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def stub_tenon_request(status, body, app_id = Mortise::TENON_APP_ID)
  stub_request(:post, 'https://tenon.io/api/').
    with( body:    { key: '1234', url: 'http://validationhell.com', appID: app_id },
          headers: { 'Cache-Control' => 'no-cache',
                     'Content-Type'  => 'application/x-www-form-urlencoded' }).
    to_return(status: status, body: body, headers: {})
end
