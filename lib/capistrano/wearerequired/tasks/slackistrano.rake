namespace :slackistrano do

  desc <<-DESC
    Sets some defaults for Slackistrano to not cause warnings when not using Slack notifications.
  DESC
  task :defaults do
    set_if_empty :slackistrano, false
  end
  before 'deploy', 'slackistrano:defaults'
end
