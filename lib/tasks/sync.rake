namespace :sync do

  desc 'Copy common models and tests from Master'
  task :copy do
    path = Rails.root.split.first
    source_path = "#{path}/pajamadeals-backend"
    dest_path = Rails.root

    # Copy all models
    %x{cp #{source_path}/app/models/*.rb #{dest_path}/app/models/}
    %x{cp #{source_path}/app/uploaders/*.rb #{dest_path}/app/uploaders/}

    # %x{cp #{source_path}/db/migrate/*.rb #{dest_path}/db/migrate/}
    %x{cp #{source_path}/config/database.yml #{dest_path}/config/database.yml}
  end
end
