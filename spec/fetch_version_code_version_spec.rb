describe Fastlane::FetchVersionCode do
  describe '#VERSION' do
    it 'should returns version' do
      expect(Fastlane::FetchVersionCode::VERSION).to eq('0.1.2')
    end
  end
end
