# fetch_version_code Fastlane plugin

[![Gem](https://img.shields.io/gem/v/fastlane-plugin-fetch_version_code)](https://rubygems.org/gems/fastlane-plugin-fetch_version_code)
[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-fetch_version_code)
[![Build Status](https://travis-ci.com/CoorpAcademy/fastlane-plugin-fetch_version_code.svg?branch=master)](https://travis-ci.com/CoorpAcademy/fastlane-plugin-fetch_version_code)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

> _Fastlane plugin_ to help you **fetch version number/code** from some API/HTTP Endpoint
## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-fetch_version_code`, add it to your project by running:

```bash
fastlane add_plugin fetch_version_code
```

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

Here is how you could use the plugin to fetch version number from some API endpoint.

```ruby
version_code = fetch_version_code(
    endpoint: "api.whatever.org/api/build/next-build-number",
    method: :post,
    secret_header: 'Api-Secret',
    secret_value: ENV['VERSION_API_SECRET']
)
```


## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
