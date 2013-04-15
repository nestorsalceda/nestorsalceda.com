set :application, "nestorsalceda.com"
set :repository,  "_site"
set :scm, :none

set :deploy_to, "/srv/nestorsalceda.com"
set :deploy_via, :copy
set :copy_compression, :gzip

role :web, "nestorsalceda.com"
role :app, "nestorsalceda.com"
role :db,  "nestorsalceda.com"

set :user, 'nestor'
set :group, user
set :use_sudo, false

namespace :deploy do
  [:start, :stop, :restart, :finalize_update].each do |t|
    desc "#{t} task is a no-op with jekyll"
    task t, :roles => :app do ; end
  end

  desc 'Run jekyll to update site before uploading'
  task :update_jekyll do
    %x(rm -rf _site/* && jekyll)
  end
end

before 'deploy:update', 'deploy:update_jekyll'
