namespace :composer do

  desc <<-DESC
    Deletes all cached packages from composer's cache directory.
  DESC
  task :clear_cache do
    on roles(:app) do
      within fetch(:release_path) do
        execute "composer clear-cache"
      end
    end
  end
end