namespace :deploy do

  desc <<-DESC
    Clean up all old releases but the last.
  DESC
  task :cleanup_all do
    set :keep_releases, 1
    invoke "deploy:cleanup"
  end
end
