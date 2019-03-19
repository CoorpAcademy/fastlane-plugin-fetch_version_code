describe Fastlane::Actions::FetchVersionCodeAction do
  describe '#run' do
    it 'should crash without appropriate config' do
      expect {
        Fastlane::Actions::FetchVersionCodeAction.run({})
      }.to raise_error 'Need either :host and :path or :endpoint arguments'
    end
    it 'should run action' do
      allow(Fastlane::Helper::FetchVersionCodeHelper).to receive(:fetch_version_code).and_return('42')

      expect(Fastlane::UI).to receive(:message).with('About to fetch a version code')
      expect(Fastlane::UI).to receive(:success).with("Got 'version code': 42")
      result = Fastlane::Actions::FetchVersionCodeAction.run(host: 'domain.tld', path: 'version/ios')
      expect(result).to eq('42')
    end
  end

  describe '#description' do
    it 'should return description' do
      result = Fastlane::Actions::FetchVersionCodeAction.description
      expect(result).to eq('Fetch (and increment) version code for given platform')
    end
  end

  describe '#authors' do
    it 'should return authors' do
      result = Fastlane::Actions::FetchVersionCodeAction.authors
      expect(result).to eq(['AdrieanKhisbe', 'VincentCATILLON'])
    end
  end

  describe '#return_value' do
    it 'should return return_value' do
      result = Fastlane::Actions::FetchVersionCodeAction.return_value
      expect(result).to eq('Version code of given platform')
    end
  end

  describe '#available_options' do
    it 'should return available_options' do
      result = Fastlane::Actions::FetchVersionCodeAction.available_options
      expect(result.map {|opt| opt.key}).to eq %i(endpoint host path method secret_header secret_value)
    end
  end

  describe '#is_supported' do
    it 'should return false' do
      result = Fastlane::Actions::FetchVersionCodeAction.is_supported?(:windows)
      expect(result).to be false
    end

    it 'should return true' do
      result = Fastlane::Actions::FetchVersionCodeAction.is_supported?(:ios)
      expect(result).to be true
    end
  end
end
