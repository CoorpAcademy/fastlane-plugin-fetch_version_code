require 'fastlane_core/ui/ui'
require 'http'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class FetchVersionCodeHelper
      def self.fetch_version_code(params)
        url = self.get_api_url(params)
        UI.message("Calling API: #{url}")

        res = HTTP.headers(api_secret: params[:secret]).post(url)

        if res.status != 200
          UI.error("Some error occureds [status:#{res.status}]: #{res.body}")
          UI.crash!(res.body)
        end

        return res.body.to_s
      end

      def self.get_api_url(params)
        return "https://#{params[:version_api_host]}/build/api/v1/versions/#{params[:platform]}/increment"
      end
    end
  end
end
