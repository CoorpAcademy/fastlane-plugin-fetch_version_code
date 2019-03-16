require 'fastlane/action'
require_relative '../helper/fetch_version_code_helper'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Actions
    class FetchVersionCodeAction < Action
      def self.run(params)
        UI.message("About to fetch a version code for: #{params[:platform]}")

        version_code = Helper::FetchVersionCodeHelper.fetch_version_code(params)
        UI.success("Got version code: #{version_code}")

        return version_code
      end

      def self.description
        'Fetch (and increment) version code for given platform'
      end

      def self.authors
        ['AdrieanKhisbe', 'VincentCATILLON']
      end

      def self.return_value
        'Version code of given platform'
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :version_api_host,
            env_name: 'VERSION_API_HOST',
            description: 'API Token for FetchVersionCodeAction',
            is_string: true,
            default_value: 'api.coorpacademy.com'
          ),
          FastlaneCore::ConfigItem.new(key: :platform, is_string: false, description: 'The platform to fetch version for'),
          FastlaneCore::ConfigItem.new(key: :secret, env_name: 'VERSION_API_SECRET')
        ]
      end

      def self.is_supported?(platform)
        [:ios, :android].include?(platform)
      end
    end
  end
end
