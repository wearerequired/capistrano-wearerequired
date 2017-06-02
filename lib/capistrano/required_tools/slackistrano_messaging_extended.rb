require 'slackistrano/capistrano'

module Capistrano
  module RequiredTools
    class SlackistranoMessagingExtended < Slackistrano::Messaging::Base
      # Get current revision
      def revision(default = 'Unknown')
        fetch(:current_revision)
      end

      # Suppress updating message.
	  def payload_for_updating
	    nil
	  end

	  # Suppress reverting message.
	  def payload_for_reverting
	    nil
	  end

      def payload_for_reverted
        make_message(super.merge(color: 'good'))
      end

      def payload_for_failed
        make_message(super.merge(color: 'danger'))
      end

      # More detailed updated message.
      def payload_for_updated
      {
        attachments: [{
          color: 'good',
          title: application + ' deployed :white_check_mark:',
	      fields: [{
            title: 'Environment',
       	    value: stage.capitalize,
            short: true
          }, {
            title: 'Branch',
            value: revision ? branch + ' (' + revision + ')' : branch,
            short: true
          }, {
            title: 'Person',
            value: deployer,
            short: true
          }, {
            title: 'Time',
            value: elapsed_time,
            short: true
          }],
          fallback: super[:text]
        }]
      }
      end

      private ##################################################

      def make_message(options={})
        attachment = options.reject{|k, v| v.nil? }
        {attachments: [attachment]}
      end

    end
  end
end
