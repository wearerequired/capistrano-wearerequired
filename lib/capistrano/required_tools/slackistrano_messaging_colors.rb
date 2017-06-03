require 'slackistrano/capistrano'

module Capistrano
  module RequiredTools
    class SlackistranoMessagingColors < Slackistrano::Messaging::Base

      def initialize(env: nil, team: nil, channel: nil, token: nil, webhook: nil, icon_url: nil, icon_emoji: nil)
        super(env: env, team: team, channel: channel, token: token, webhook: webhook)
        @icon_url = icon_url
        @icon_emoji = icon_emoji
      end

      def payload_for_updating
        make_message(super.merge(color: '#E7E7E7'))
      end

      def payload_for_reverting
        make_message(super.merge(color: '#E7E7E7'))
      end

      def payload_for_updated
        make_message(super.merge(color: 'good'))
      end

      def payload_for_reverted
        make_message(super.merge(color: 'good'))
      end

      def payload_for_failed
        make_message(super.merge(color: 'danger'))
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

      private ##################################################

      def make_message(options={})
        attachment = options.reject{|k, v| v.nil? }
        {attachments: [attachment]}
      end

    end
  end
end
