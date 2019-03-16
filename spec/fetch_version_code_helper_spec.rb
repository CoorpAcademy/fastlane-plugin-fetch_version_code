describe Fastlane::Helper::FetchVersionCodeHelper do
  describe '#get_api_url' do
    it 'should create URL' do
      result = Fastlane::Helper::FetchVersionCodeHelper.get_api_url(version_api_host: 'domain.tld', platform: 'ios')
      expect(result).to eq('https://domain.tld/build/api/v1/versions/ios/increment')
    end
  end

  describe '#fetch_version_code' do
    it 'should raise error' do
      allow(Fastlane::Helper::FetchVersionCodeHelper).to receive(:get_api_url).and_return('https://domain.tld')
      stub_request(:post, 'https://domain.tld')
        .with(headers: { api_secret: 'foobarbaz' })
        .to_return(status: 404, body: '42')

      expect(Fastlane::UI).to receive(:message).with('Calling API: https://domain.tld')
      expect(Fastlane::UI).to receive(:error).with('Some error occureds [status:404 Not Found]: 42')
      expect { Fastlane::Helper::FetchVersionCodeHelper.fetch_version_code(version_api_host: 'domain.tld', platform: 'ios', secret: 'foobarbaz') }.to raise_error('42')
    end

    it 'should fetch version' do
      allow(Fastlane::Helper::FetchVersionCodeHelper).to receive(:get_api_url).and_return('https://domain.tld')
      stub_request(:post, 'https://domain.tld')
        .with(headers: { api_secret: 'foobarbaz' })
        .to_return(status: 200, body: '42')

      expect(Fastlane::UI).to receive(:message).with('Calling API: https://domain.tld')
      result = Fastlane::Helper::FetchVersionCodeHelper.fetch_version_code(version_api_host: 'domain.tld', platform: 'ios', secret: 'foobarbaz')
      expect(result).to eq('42')
    end
  end
end
