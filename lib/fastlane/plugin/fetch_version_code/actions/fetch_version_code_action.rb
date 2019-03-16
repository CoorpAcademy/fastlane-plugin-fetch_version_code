require 'fastlane/action'
require_relative '../helper/fetch_version_code_helper'
require 'http'

module Fastlane
  module Actions
    class FetchVersionCodeAction < Action
      def self.run(params)
        UI.important "About to fetch a version code for: #{params[:platform]}"
        url = "https://#{params[:version_api_host]}/build/api/v1/versions/#{params[:platform]}/increment"
        res = HTTP.headers(:api_secret => params[:secret]).post(url)
        if res.status != 200
          UI.error "Some error occureds [status:#{res.status}]: #{res.body}"
          UI.crash!(res.body)
        end
        version_code = res.body.to_s

        UI.success "Got version Code #{version_code}"
        return version_code
      end

      def self.description
        "Fetch (and increment) version code for given platform"
      end

      def self.authors
        ["AdrieanKhisbe"]
      end

      def self.output
        []
      end

      def self.return_value
        "Version code of given platform"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :version_api_host,
            env_name: "VERSION_API_HOST",
            description: "API Token for FetchVersionCodeAction",
            is_string: true,
            default_value: "api.coorpacademy.com"
          ),
          FastlaneCore::ConfigItem.new(key: :platform, is_string: false, description: "The platform to fetch version for"),
          FastlaneCore::ConfigItem.new(key: :secret, env_name: "VERSION_API_SECRET"),
        ]
      end

      def self.is_supported?(platform)
        [:ios, :android].include?(platform)
      end
    end
  end
end
