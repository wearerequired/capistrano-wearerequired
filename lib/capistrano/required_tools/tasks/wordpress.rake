# WordPress

# WordPress Translations

# Define the supported languages in deploy.rb
# set :wp_langauges, [
#   'de_DE',
#   'fr_FR'
# ]

namespace :wordpress do

  desc 'Install WordPress translations'
  task :install_translations do
    on roles(:app) do
      within release_path do
        fetch(:wp_languages).each do |language|
          execute :wp, "core language install #{language}"
        end
      end
    end
  end

  desc 'Update WordPress translations'
  task :update_translations do
    on roles(:app) do
      within release_path do
        execute :wp, "core language update"
      end
    end
  end
end
