namespace :composer do

  desc <<-DESC
    Deletes all cached packages from composer's cache directory.
  DESC
  task :clear_cache do
    invoke "composer:run", "clear-cache"
  end
end
