desc "Remove all but the last release"
task :cleanup_all do
  set :keep_releases, 1
  invoke "deploy:cleanup"
end
