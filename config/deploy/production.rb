server '104.236.79.184', user: 'root', roles: %(web app)
set :branch, 'master'
set :deploy_to, '/var/www/chatlinebot/'
set :linked_files, ['.env']
set :linked_dirs, %w(public tmp)
set :ssh_options, forward_agent: true
set :passenger_restart_with_touch, true

set :keep_releases, 5
set :rack_env, :production
