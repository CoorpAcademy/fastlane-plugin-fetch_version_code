$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'simplecov'

SimpleCov.minimum_coverage(100)
SimpleCov.start do
  add_filter('vendor')
end
SimpleCov.coverage_dir('coverage')

# This module is only used to check the environment is currently a testing env
module SpecHelper
end

require 'fastlane' # to import the Action super class
require 'fastlane/plugin/fetch_version_code' # import the actual plugin

Fastlane.load_actions # load other actions (in case your plugin calls other actions or shared values)

require 'webmock/rspec'
include(WebMock)
