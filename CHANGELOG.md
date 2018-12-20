# Changelog

## 1.3.1

* Correct Slackistrano defaults tasks hook.

## 1.3.0

* Improve defaults for Slackistrano  
  Prevents warnings when not using Slack notifications at all.
* Improve WP-CLI error handling  
  Prevents clutter and early deployment fails when WP-CLI language commands error.

## 1.2.0

* Support WP-CLI 2.0.0 and newer  
  In WP-CLI 2.0.0 the `wp language plugin` and `wp language theme` commands were introduced.

## 1.1.0

* Support WP-CLI 1.2.0 and newer  
  In WP-CLI v1.2.0 the  `wp core language` command was changed to `wp language core`.
* Get deployer's name from Git config in `SlackistranoMessagingElements`

## 1.0.0

* Renamed to `Capistrano::Wearerequired` and published on [rubygems.org](https://rubygems.org/gems/capistrano-wearerequired).
* Added `wordpress:clear_opcache` task.
* Added new messaging classes for Slackistrano for more informative notifications.
  * Moved support for custom icon (via `icon_url` or `icon_emoji`) and bot name (via `username`) to its own class `SlackistranoMessagingElements`.
  * `SlackistranoExpandedGitMessaging` extends `SlackistranoMessagingColors` which extends `SlackistranoMessagingElements`.

## 0.3.0

* Added `deploy:cleanup_all` task.
* Added `wordpress:install_translations` and `wordpress:update_translations` tasks.

## 0.2.0

* Added `composer:clear_cache` task.

## 0.1.0

* Initial version.
