require 'spec_helper'

describe Mortise do
  before(:each) do
    stub_request(:post, 'https://tenon.io/api/').
      with( body:    { key: '1234', url: 'http://validationhell.com' },
            headers: { 'Cache-Control': 'no-cache',
                       'Content-Type':  'application/x-www-form-urlencoded'}).
      to_return(status: 200, body: fixture_file('validationhell.json'), headers: {})
  end

  describe 'initialization' do
    it 'sets the URL of the document to check' do
      checker = Mortise.check('http://validationhell.com', '1234')

      expect(checker.url).to eq 'http://validationhell.com'
    end

    it 'sets the API key' do
      checker = Mortise.check('http://validationhell.com', '1234')

      expect(checker.key).to eq '1234'
    end

    it 'has a default tenon URI' do
      checker = Mortise.check('http://validationhell.com', '1234')

      expect(checker.tenon_uri).to eq 'https://tenon.io/api/'
    end

    it 'tenon URI can be set' do
      checker = Mortise.check('http://validationhell.com', '1234',
                              tenon_uri: 'http://checker.example.com/')

      expect(checker.tenon_uri).to eq 'http://checker.example.com/'
    end
  end

  describe 'checking markup' do
    let(:checker) { Mortise.check('http://validationhell.com', '1234') }

    it 'returns the raw JSON response' do
      expect(checker.raw).to eq JSON.parse(fixture_file('validationhell.json'))
    end

    it 'returns the list of issues' do
      expect(checker.issues.size).to eq 6
      expect(checker.issues.first.error_title).to eq "Image missing alt attribute"
    end

    it 'filters errors from the issues' do
      expect(checker.errors.size).to eq 5
      expect(checker.errors.first.error_title).to eq "Image missing alt attribute"
    end

    it 'filters warnings from the messages' do
      expect(checker.warnings.size).to eq 1
      expect(checker.warnings.first.error_title).to eq "Blank link text found"
    end
  end
end
