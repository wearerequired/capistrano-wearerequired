# Capistrano::Wearerequired &middot; [![Gem Version](https://badge.fury.io/rb/capistrano-wearerequired.svg)](https://rubygems.org/gems/capistrano-wearerequired)

Capistrano::Wearerequired is a collection of recipes and tasks specialized on WordPress deployment.


## Installation

1. Add this line to your application's Gemfile to install the latest stable version:

   ```ruby
   gem 'capistrano-wearerequired', '~> 1.0'
   ```

2. Execute:

   ```
   $ bundle
   ```

3. Require the library in your application's Capfile:

   ```ruby
   require 'capistrano/wearerequired'
   ```


## Usage

### Colors for Slackistrano

The class `SlackistranoMessagingColors` adds colors to the deploy messages posted to Slack.

Example:
```ruby
set :slackistrano, {
    klass: Capistrano::Wearerequired::SlackistranoMessagingColors,
    channel: '#your-channel',
    webhook: 'your-incoming-webhook-url'
}
```

### Extended Messaging for Slackistrano

The class `SlackistranoMessagingExtended` adds colors, a link to the current diff, the current revision and branch, the name of the deployer and suppresses updating messages.

Example:
```ruby
set :slackistrano, {
    klass: Capistrano::Wearerequired::SlackistranoMessagingExtended,
    channel: '#your-channel',
    webhook: 'your-incoming-webhook-url',
    icon_emoji: ':ship:',
    username: 'deploybot'
}
```

See [Customizing the Messaging](https://github.com/phallstrom/slackistrano/tree/v3.1.0#customizing-the-messaging) for more information.

### Additional tasks

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

To **clear OPcache** of your site set `:wp_clear_opcache, true` and run:

```
cap staging wordpress:clear_opcache
```

(Requires the [WP-CLI Clear OPcache](https://packagist.org/packages/wearerequired/wp-cli-clear-opcache) plugin.)


## Changelog

### 1.0.0

* Renamed to `Capistrano::Wearerequired` and published on [rubygems.org](https://rubygems.org/gems/capistrano-wearerequired).

### 0.4.0

* Added `wordpress:clear_opcache` task.
* Added new messaging class for Slackistrano for more informative notifications.
* Updated both messaging classes to support a custom icon (via `icon_url` or `icon_emoji`) and bot name (via `username`).

### 0.3.0

* Added `deploy:cleanup_all` task.
* Added `wordpress:install_translations` and `wordpress:update_translations` tasks.

### 0.2.0

* Added `composer:clear_cache` task.

### 0.1.0

* Initial version.
