require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'highline/import'
require 'securerandom'

set :domain, ask('Domain: ') { |q| q.default = 'right-books.com' }
set :deploy_to, '/var/www/right-books'
set :repository, 'git@github.com:mwean/right-books.git'
set :branch, 'master'
set :forward_agent, true

set :shared_paths, ['log']

set :user, 'root'

task :environment do
end

task setup: :environment do
  get_env_values
  build_host_env_file
  set_up_swapfile
  generate_ssh_key
  install_new_relic
  add_known_hosts

  deploy do
    create_log_dir
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
  end

  build_docker_containers
  build_app_env_file
  set_up_app
  boot_app
  print_public_key
end

def get_env_values
  set :new_relic_key, ask('New Relic key:')
  set :bugsnag_key, ask('Bugsnag key:')
  set :aws_access_key, ask('AWS access key:')
  set :aws_secret_key, ask('AWS secret key:')
  set :amazon_associate_tag, ask('Amazon associate tag:')
  set :secret_key_base, SecureRandom.hex(64)
  set :db_password, SecureRandom.hex(16)
  set :db_url, "postgres://postgres:#{db_password}@db/right-books?pool=5"
end

def build_host_env_file
  host_env_vars = erb('infrastructure/host/env')

  queue 'echo "-----> Setting up host env variables"'
  queue %(echo "#{host_env_vars}" >> /etc/profile.d/env.sh)
  queue 'chmod +x /etc/profile.d/env.sh'
  queue 'source /etc/profile.d/env.sh'
  queue 'echo "-----> Done."'
end

def set_up_swapfile
  queue 'echo "-----> Setting up swapfile"'
  queue 'sudo fallocate -l 4G /swapfile'
  queue 'sudo chmod 600 /swapfile'
  queue 'sudo mkswap /swapfile'
  queue 'sudo swapon /swapfile'
  queue 'sudo echo "/swapfile  none  swap  sw  0  0" >> /etc/fstab'
  queue 'echo "-----> Done."'
end

def generate_ssh_key
  queue 'echo "-----> Generating SSH key"'
  queue 'ssh-keygen -f ~/.ssh/id_rsa -t rsa -N "" -C "right-books-server"'
  queue 'echo "-----> Done."'
end

def install_new_relic
  queue 'echo "-----> Installing New Relic"'

  queue <<-SH
    echo "deb http://apt.newrelic.com/debian/ newrelic non-free" >> \
    /etc/apt/sources.list.d/newrelic.list
  SH

  queue 'wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -'
  queue 'apt-get update && apt-get install newrelic-sysmond'
  queue "nrsysmond-config --set license_key=#{new_relic_key}"
  queue '/etc/init.d/newrelic-sysmond start'
  queue 'echo "-----> Done."'
end

def create_log_dir
  queue 'echo "-----> Setting up log dir"'
  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/log")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log")
  queue 'echo "-----> Done."'
end

def add_known_hosts
  queue! <<-SH
    echo "github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >> ~/.ssh/known_hosts
  SH
end

def build_docker_containers
  queue 'echo "-----> Building Docker containers"'
  queue "cd #{deploy_to}/#{current_path}"
  queue! 'bin/build'
  queue 'echo "-----> Done."'
end

def build_app_env_file
  app_env_vars = erb('infrastructure/app/env')

  queue 'echo "-----> Setting up app env variables"'
  queue %(echo "#{app_env_vars}" >> #{deploy_to}/#{shared_path}/.env)
  queue 'echo "-----> Done."'
end

def set_up_app
  queue 'echo "-----> Setting up app"'

  queue <<-SH
    docker run -d --name db -e "POSTGRES_PASSWORD=#{db_password}" \
    -v /var/lib/postgresql/data:/var/lib/postgresql/data postgres:latest
  SH

  queue <<-SH
    docker run --rm -e "RAILS_ENV=production" -e "DATABASE_URL=#{db_url}" \
    --link db:db mwean/right-books-app \
    bundle exec rake db:create db:schema:load db:seed
  SH

  queue 'docker stop db && docker rm db'
  queue 'echo "-----> Done."'
end

def boot_app
  queue 'echo "-----> Booting app"'
  queue! 'bin/boot'
  queue 'echo "-----> Done."'
end

def print_public_key
  queue 'echo "-----> Add this public key to Github:"'
  queue! 'cat ~/.ssh/id_rsa.pub'
end

desc 'Deploys the current version to the server.'
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
    end
  end
end
