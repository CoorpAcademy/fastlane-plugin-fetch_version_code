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
          FastlaneCore::ConfigItem.new(key: :endpoint, description: 'Version Api endpoint', is_string: true, default_value: ''),
          FastlaneCore::ConfigItem.new(key: :host, description: 'The host hosting the version API'),
          FastlaneCore::ConfigItem.new(key: :path, description: 'The path of the version API'),
          FastlaneCore::ConfigItem.new(key: :method, description: 'The method of the endpoint', is_string: false, default_value: :get),
          FastlaneCore::ConfigItem.new(key: :secret_header, default_value: '')
          FastlaneCore::ConfigItem.new(key: :secret_value, default_value: '')
        ]
      end

      def self.is_supported?(platform)
        [:ios, :android].include?(platform)
      end
    end
  end
end
