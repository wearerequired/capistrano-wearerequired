namespace :wordpress do

  desc <<-DESC
    Install WordPress translations.
  DESC
  task :install_translations do
    next unless fetch(:wp_languages).any?

    on roles(:app) do
      within release_path do
        fetch(:wp_languages).each do |language|
          execute :wp, "language core install #{language} 2> /dev/null", raise_on_non_zero_exit: false
          execute :wp, "plugin list --field=name | xargs -I % wp language plugin install % #{language} 2> /dev/null", raise_on_non_zero_exit: false
          execute :wp, "theme list --field=name | xargs -I % wp language theme install % #{language} 2> /dev/null", raise_on_non_zero_exit: false
        end
      end
    end
  end

  desc <<-DESC
    Update WordPress translations.
  DESC
  task :update_translations do
    next unless fetch(:wp_languages).any?

    on roles(:app) do
      within release_path do
        execute :wp, "language core update"
        execute :wp, "language plugin update --all"
        execute :wp, "language theme update --all"
      end
    end
  end

  desc <<-DESC
    Clear OPcache.
  DESC
  task :clear_opcache do
    next unless fetch(:wp_clear_opcache)

    on roles(:app) do
      within release_path do
        execute :wp, "plugin activate wp-cli-clear-opcache --quiet"
        execute :wp, "opcache clear"
      end
    end
  end

  after 'deploy:finishing', 'wordpress:install_translations'
  after 'deploy:finishing', 'wordpress:update_translations'
  after 'deploy:finishing', 'wordpress:clear_opcache'
end

namespace :load do
  task :defaults do
    set :wp_languages, []
    set :wp_clear_opcache, false
  end
end
