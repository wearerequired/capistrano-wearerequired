# Capistrano::RequiredTools

A collection of tools for Capistrano.


## Installation

1. Add this line to your application's Gemfile to install the latest stable version:

   ```ruby
   gem 'capistrano-required_tools', :git => 'git@github.com:wearerequired/capistrano-required_tools.git', :branch => 'stable'
   ```

   Use `:tag => 'v0.0.2'` for a specific version.

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
    klass: Capistrano::RequiredTools::SlackistranoMessagingColors,
    channel: '#your-channel',
    webhook: 'your-incoming-webhook-url'
}
```

See [Customizing the Messaging](https://github.com/phallstrom/slackistrano/tree/v3.1.0#customizing-the-messaging) for more information.

### Additonal tasks

To **delete all content from Composer's cache directories** run:

```
cap staging composer:clear_cache
```

To **clean up all old releases** but the last run:

```
cap staging deploy:cleanup_all
```

To **install WordPress translations** set `:wp_language` and run:


```
set :wp_languages, [
	'de_DE',
	'it_IT
]

cap staging wordpress:install_translations
```

To **update WordPress translations** run:

```
cap staging wordpress: update_translations
```

## Changelog

### 0.0.3

* Added `deploy:cleanup_all` task.
* Added `wordpress:install_translations` and `wordpress:update_translations` tasks.

### 0.0.2

* Added `composer:clear_cache` task.

### 0.0.1

* Initial version.