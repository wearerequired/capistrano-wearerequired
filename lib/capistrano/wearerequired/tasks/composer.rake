namespace :composer do

  desc <<-DESC
    Deletes all content from Composer's cache directories.
  DESC
  task :clear_cache do
    invoke "composer:run", "clear-cache"
  end
end
