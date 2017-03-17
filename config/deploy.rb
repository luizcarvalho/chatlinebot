# config valid only for current version of Capistrano
lock '3.7.2'

set :application, 'chatlinebot'
set :repo_url, 'https://github.com/luizcarvalho/chatlinebot'
set :ssh_options, forward_agent: true

namespace :deploy do
  task :start do
    on roles(:all) do |_host|
      execute "touch #{deploy_to}current/tmp/restart.txt"
    end
  end

  task :stop do
    # Do nothing
  end

  desc 'Restart Application'
  task :restart do
    on roles(:all) do |_host|
      execute "touch #{deploy_to}current/tmp/restart.txt"
    end
  end

  task :finalize_update do
    # Do nothing
  end

  # task :after_deploy do
  #  run 'cp #{current_release}/env.rb #{current_release}/env.rb-"
  #  run "echo ENV\[\\'GEM_PATH\\'\] = \\'#{gempath}\\' + \\\":\#{ENV[\\'GEM_PATH\\']}\\\" > #{current_release}/env.rb"
  #  run "cat #{current_release}/env.rb- >> #{current_release}/env.rb"
  #  run "rm #{current_release}/env.rb-"
  #  deploy::cleanup
  # end
end
