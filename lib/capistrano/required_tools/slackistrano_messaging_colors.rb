require 'slackistrano/capistrano'

module Capistrano
  module RequiredTools
    class SlackistranoMessagingColors < Slackistrano::Messaging::Base

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

      private ##################################################

      def make_message(options={})
        attachment = options.reject{|k, v| v.nil? }
        {attachments: [attachment]}
      end

    end
  end
end
