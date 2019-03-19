describe Fastlane::Helper::FetchVersionCodeHelper do
  describe '#get_api_url' do
    it 'should create URL from endpoint' do
      result = Fastlane::Helper::FetchVersionCodeHelper.get_api_url(endpoint: 'domain.tld/endpoint')
      expect(result).to eq('https://domain.tld/endpoint')
    end
    it 'should create URL from endpoint with protocol' do
      result = Fastlane::Helper::FetchVersionCodeHelper.get_api_url(endpoint: 'https://the-versio.io')
      expect(result).to eq('https://the-versio.io')
    end
    it 'should create URL from host and path' do
      result = Fastlane::Helper::FetchVersionCodeHelper.get_api_url(host: 'domain.tld', path: '/version/ios')
      expect(result).to eq('https://domain.tld/version/ios')
    end
    it 'should raise exception otherwise' do
      expect { Fastlane::Helper::FetchVersionCodeHelper.get_api_url({}) }.to raise_error 'No enough params to get api_url'
    end
  end

  describe '#fetch_version_code' do
    it 'should raise error for non existing key' do
      allow(Fastlane::Helper::FetchVersionCodeHelper).to receive(:get_api_url).and_return('https://domain.tld/version/android')
      stub_request(:get, 'https://domain.tld/version/android')
        .to_return(status: 404, body: 'not found')

      expect(Fastlane::UI).to receive(:message).with('Calling API: https://domain.tld/version/android')
      expect(Fastlane::UI).to receive(:error).with('Some error occureds [status:404 Not Found]: not found')
      expect { 
        Fastlane::Helper::FetchVersionCodeHelper.fetch_version_code(host: 'domain.tld', path: '/version/android') 
      }.to raise_error('not found')
    end

    it 'should fetch version with a get without secret' do
      allow(Fastlane::Helper::FetchVersionCodeHelper).to receive(:get_api_url).and_return('https://domain.tld')
      stub_request(:get, 'https://domain.tld')
        .to_return(status: 200, body: '42')

      expect(Fastlane::UI).to receive(:message).with('Calling API: https://domain.tld')
      result = Fastlane::Helper::FetchVersionCodeHelper.fetch_version_code(version_api_host: 'domain.tld', platform: 'ios')
      expect(result).to eq('42')
    end
    it 'should fetch version with a get with secret' do
      allow(Fastlane::Helper::FetchVersionCodeHelper).to receive(:get_api_url).and_return('https://domain.tld')
      stub_request(:get, 'https://domain.tld')
        .with(headers: { api_secret: 'foobarbaz' })
        .to_return(status: 200, body: '42')

      expect(Fastlane::UI).to receive(:message).with('Calling API: https://domain.tld')
      result = Fastlane::Helper::FetchVersionCodeHelper.fetch_version_code(
        version_api_host: 'domain.tld', platform: 'ios', secret_header: 'api_secret', secret_value: 'foobarbaz'
      )
      expect(result).to eq('42')
    end
    it 'should fetch version with a post' do
      allow(Fastlane::Helper::FetchVersionCodeHelper).to receive(:get_api_url).and_return('https://domain.tld')
      stub_request(:post, 'https://domain.tld')
        .to_return(status: 200, body: '42')

      expect(Fastlane::UI).to receive(:message).with('Calling API: https://domain.tld')
      result = Fastlane::Helper::FetchVersionCodeHelper.fetch_version_code(version_api_host: 'domain.tld', platform: 'ios', secret: 'foobarbaz', method: :post)
      expect(result).to eq('42')
    end
  end
end
