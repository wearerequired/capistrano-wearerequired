require 'slackistrano/capistrano'

module Capistrano
  module RequiredTools
    class SlackistranoMessagingColors < Slackistrano::Messaging::Base

    def initialize(env: nil, team: nil, channel: nil, token: nil, webhook: nil, icon_url: 'https://cloud.githubusercontent.com/assets/1785641/26352641/e2be8d00-3fbc-11e7-939b-5e4be8084043.png' )
       @env = env
       @team = team
       @channel = channel
       @token = token
       @webhook = webhook
       @icon_url = icon_url
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
        @icon_url
      end

      private ##################################################

      def make_message(options={})
        attachment = options.reject{|k, v| v.nil? }
        {attachments: [attachment]}
      end

    end
  end
end
