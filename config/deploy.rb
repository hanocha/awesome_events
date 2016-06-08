# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'awesome_events'
set :repo_url, 'git@github.com:hanocha/awesome_events.git'
set :branch, 'add-deploy-settings'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/awesome_events'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')
set :linked_dirs, (fetch(:linked_dirs) + ['tmp/pids'])

# Default value for default_env is {}
set :default_env, {
  rbenv_root: "/home/ops/.rbenv",
  path: "/home/ops/.rbenv/shims:/home/ops/.rbenv/bin:$PATH"
}

set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# Default value for keep_releases is 5
set :keep_releases, 5

set :unicorn_config_path, 'config/unicorn.rb'

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
