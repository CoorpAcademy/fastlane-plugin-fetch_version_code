describe Fastlane::Actions::FetchVersionCodeAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The fetch_version_code plugin is working!")

      Fastlane::Actions::FetchVersionCodeAction.run(nil)
    end
  end
end
