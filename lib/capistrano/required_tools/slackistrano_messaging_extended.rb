require 'slackistrano/capistrano'

module Capistrano
  module RequiredTools
    class SlackistranoMessagingExtended < Slackistrano::Messaging::Base
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

      # Get current revision
      def revision(default = 'Unknown')
        fetch(:current_revision, default)
      end

      # Get current revision URL
	  def revision_url
	    repo = repo_url.match(/(git@|https:\/\/)(?<host>([\w\.@]+))(\/|:)(?<owner>[\w,\-,\_]+)\/(?<repo>[\w,\-,\_]+)(.git){0,1}((\/){0,1})/)
        repo.nil? ? revision : "<https://%{host}/%{owner}/%{repo}/%{commit}/%{revision}|%{revision_short}>" % {
          :host => repo[:host],
          :owner => repo[:owner],
          :repo => repo[:repo],
          :commit => repo[:host] == 'bitbucket.org' ? 'commits' : 'commit',
          :revision => revision,
          :revision_short => revision[0..10]
        }
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
            value: branch,
            short: true
          }, {
            title: 'Person',
            value: deployer,
            short: true
          }, {
            title: 'Revision',
            value: revision_url,
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
