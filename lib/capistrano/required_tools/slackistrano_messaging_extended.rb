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
        else
          current_revision_url
        end
      end

      # Get current revision URL
      def current_revision_url
        "<https://%{host}/%{owner}/%{repo}/%{commit}/%{revision}|%{revision_short}>" % {
          :host => repo[:host],
          :owner => repo[:owner],
          :repo => repo[:repo],
          :commit => 'bitbucket.org' == repo[:host] ? 'commits' : 'commit',
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
          :compare => 'bitbucket.org' == repo[:host] ? 'branches/compare' : 'compare',
          :current_revision => current_revision,
          :previous_revision => previous_revision,
          :revision_short => previous_revision[0..7] + '...' + current_revision[0..7]
        }
      end

      def author_icon
        "https://required.com/content/themes/required-valencia/img/character-%{name}-300x300.png" % { name: deployer.downcase }
      end

      def author_link
        "https://required.com/team/%{name}/" % { name: deployer.downcase }
      end

      def footer_icon
        if repo.nil?
         ''
        elsif 'bitbucket.org' == repo[:host]
          'https://bitbucket.org/site/master/avatar/64/'
        elsif 'gitlab.com' == repo[:host]
          'https://gitlab.com/uploads/system/project/avatar/13083/logo-extra-whitespace.png'
        elsif 'github.com' == repo[:host]
          'https://assets-cdn.github.com/images/modules/logos_page/GitHub-Mark.png'
        end
      end

      def footer
        if repo.nil? || current_revision.nil? || previous_revision.nil?
          ''
        else
          'Diff: ' + revision_compare_url
        end
      end

      # More detailed updated message.
      def payload_for_updated
      {
        attachments: [{
          color: 'good',
          pretext: application + ' was successfully deployed :white_check_mark:',
          author_name: deployer.capitalize,
          author_icon: author_icon,
          author_link: author_link,
          footer: footer,
          footer_icon: footer_icon,
          fields: [{
            title: 'Environment',
            value: stage.capitalize,
            short: true
          }, {
            title: 'Branch',
            value: branch,
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
