require 'fastlane_core/ui/ui'
require 'http'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class FetchVersionCodeHelper
      def self.fetch_version_code(params)
        url = self.get_api_url(params)
        UI.message("Calling API: #{url}")
        method = params[:method] || :get

        headers = params[:secret_header] ? { params[:secret_header] => params[:secret_value] } : {}
        res = HTTP.headers(headers).send(method, url)

        if res.status != 200
          UI.error("Some error occureds [status:#{res.status}]: #{res.body}")
          UI.crash!(res.body)
        end

        return res.body.to_s
      end

      def self.get_api_url(params)
        if params[:endpoint]
          return params[:endpoint] if params[:endpoint].start_with?("http:", "https:")
          return "https://#{params[:endpoint]}"
        elsif params[:host] && params[:path]
          return "https://#{params[:host]}#{params[:path]}"
        end
        raise ArgumentError, 'No enough params to get api_url'
      end
    end
  end
end
