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
	  def current_revision
	    fetch(:current_revision)
	  end

	  # Get previous revision
      def previous_revision
        fetch(:previous_revision)
      end

      # Get individual parts of the repo_url
      def repo
        repo_url.match(/(git@|https:\/\/)(?<host>([\w\.@]+))(\/|:)(?<owner>[\w,\-,\_]+)\/(?<repo>[\w,\-,\_]+)(.git){0,1}((\/){0,1})/)
      end

      # Get information about the revision being deployed
      def revision
        if repo.nil? || current_revision.nil?
          'Unknown'
        elsif previous_revision.nil?
          current_revision_url
        else
          revision_compare_url
        end
      end

      # Get current revision URL
	  def current_revision_url
        "<https://%{host}/%{owner}/%{repo}/%{commit}/%{revision}|%{revision_short}>" % {
		  :host => repo[:host],
		  :owner => repo[:owner],
		  :repo => repo[:repo],
		  :commit => repo[:host] == 'bitbucket.org' ? 'commits' : 'commit',
		  :revision => current_revision,
		  :revision_short => current_revision[0..10]
		}
      end

      # Get revision comparison
	  def revision_compare_url
        "<https://%{host}/%{owner}/%{repo}/%{compare}/%{previous_revision}...%{current_revision}|%{revision_short}>" % {
		  :host => repo[:host],
		  :owner => repo[:owner],
		  :repo => repo[:repo],
		  :compare => repo[:host] == 'bitbucket.org' ? 'branches/compare' : 'compare',
		  :current_revision => current_revision,
          :previous_revision => previous_revision,
          :revision_short => previous_revision[0..7] + '...' + current_revision[0..7]
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
            value: revision,
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
