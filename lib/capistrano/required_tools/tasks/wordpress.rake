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
end

after 'deploy:finishing', 'wordpress:install_translations'
after 'deploy:finishing', 'wordpress:update_translations'
