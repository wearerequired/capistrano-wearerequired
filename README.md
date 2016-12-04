# Capistrano::RequiredTools

A collection of tools for Capistrano.


## Installation

1. Add this line to your application's Gemfile:

   ```ruby
   gem 'capistrano-required_tools', :git => 'git@github.com:wearerequired/capistrano-required_tools.git', :tag => 'v0.0.1'
   ```

2. Execute:

   ```
   $ bundle
   ```

3. Require the library in your application's Capfile:

   ```ruby
   require 'capistrano/required_tools'
   ```
   
   
## Usage

### Colors for Slackistrano

The class `SlackistranoMessagingColors ` adds colors to the deploy messages posted to Slack.

```ruby
set :slackistrano, {
    class: Capistrano::RequiredTools::SlackistranoMessagingColors,
    channel: '#your-channel',
    webhook: 'your-incoming-webhook-url'
}
```

See [Customizing the Messaging](https://github.com/phallstrom/slackistrano/tree/v3.1.0#customizing-the-messaging) for more information.
