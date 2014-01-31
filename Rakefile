# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

OscarsMadness::Application.load_tasks

namespace :db do
  task :reset do
    last_dump = Dir[Rails.root + 'db/dumps/*.sql'].last
    #sh "pg_restore --verbose --clean --no-acl --no-owner -d oscars_development #{last_dump}"
    sh "psql oscars_development < #{last_dump}"
  end
end
