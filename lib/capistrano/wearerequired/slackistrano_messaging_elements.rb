require 'slackistrano/capistrano'

module Capistrano
  module Wearerequired
    class SlackistranoMessagingElements < Slackistrano::Messaging::Base

      def initialize(options = {})
        super(options)
      end

      # Override the deployer helper to pull the best name available (git, password file, env vars).
      def deployer
        name = `git config user.name`.strip.split.first
        name = nil if name.empty?
        name ||= Etc.getpwnam(ENV['USER']).gecos || ENV['USER'] || ENV['USERNAME']
        name
      end

    end
  end
end
