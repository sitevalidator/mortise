require 'spec_helper'

describe Mortise do
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

    describe 'successful requests' do
      before(:each) do
        stub_tenon_request(200, fixture_file('validationhell.json'))
      end

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

    describe 'failed requests' do
      it '400 Bad Request' do
        stub_tenon_request(400, fixture_file('400.json'))

        expect { checker.raw }.to raise_error(Mortise::BadRequestError, fixture_file('400.json'))
      end

      it '401 Unauthorized' do
        stub_tenon_request(401, fixture_file('401.json'))

        expect { checker.raw }.to raise_error(Mortise::UnauthorizedError, fixture_file('401.json'))
      end

      it '500 Internal Server Error' do
        stub_tenon_request(500, fixture_file('500.json'))

        expect { checker.raw }.to raise_error(Mortise::InternalServerError, fixture_file('500.json'))
      end

      it '522 Connection Time Out' do
        stub_tenon_request(522, fixture_file('522.json'))

        expect { checker.raw }.to raise_error(Mortise::ConnectionTimeOutError, fixture_file('522.json'))
      end
    end
  end
end
