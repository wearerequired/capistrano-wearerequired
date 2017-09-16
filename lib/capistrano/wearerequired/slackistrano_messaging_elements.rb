require 'slackistrano/capistrano'

module Capistrano
  module Wearerequired
    class SlackistranoMessagingElements < Slackistrano::Messaging::Base

      def initialize(env: nil, team: nil, channel: nil, token: nil, webhook: nil, icon_url: nil, icon_emoji: nil, username: nil)
        super(env: env, team: team, channel: channel, token: token, webhook: webhook)
        @icon_url = icon_url
        @icon_emoji = icon_emoji
        @username = username
      end

      def icon_url
        if @icon_url.nil?
          super
        else
          @icon_url
        end
      end

      def icon_emoji
        @icon_emoji
      end

      def username
       if @username.nil?
         super
       else
         @username
       end
      end

    end
  end
end
