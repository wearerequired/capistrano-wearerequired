namespace :slackistrano do
  task :defaults do
    set_if_empty :slackistrano, false
  end
  before 'slack:deploy', 'slackistrano:defaults'
end
