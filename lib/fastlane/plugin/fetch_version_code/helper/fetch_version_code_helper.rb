require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class FetchVersionCodeHelper
      # class methods that you define here become available in your action
      # as `Helper::FetchVersionCodeHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the fetch_version_code plugin helper!")
      end
    end
  end
end
