namespace :wordpress do

  desc <<-DESC
    Install WordPress translations.
  DESC
  task :install_translations do
    on roles(:app) do
      within release_path do
        fetch(:wp_languages, []).each do |language|
          execute :wp, "core language install #{language}"
        end
      end
    end
  end

  desc <<-DESC
    Update WordPress translations.
  DESC
  task :update_translations do
    on roles(:app) do
      within release_path do
        execute :wp, "core language update"
      end
    end
  end

  desc <<-DESC
    Clear OPcache.
  DESC
  task :clear_cache do
    on roles(:app) do
      within release_path do
        execute :wp, "plugin activate wp-cli-clear-opcache --quiet"
        execute :wp, "opcache clear"
      end
    end
  end

end

if !fetch(:wp_languages, []).empty?
  after 'deploy:finishing', 'wordpress:install_translations'
  after 'deploy:finishing', 'wordpress:update_translations'
end

if fetch(:wp_clear_opcache, false)
  after 'deploy:finishing', 'opcache:clear_cache'
end
