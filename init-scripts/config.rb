require_relative 'config/ssh'
require_relative 'config/gemfile'
require_relative 'config/migrate'

# Environment Variables
env = {
  rails_env: ENV.fetch('RAILS_ENV') { 'production' },
  user: ENV.fetch('USER') { $USER },
  app_home: ENV.fetch('APP_HOME') { '/app' },
  secret_key_base: ENV.fetch('SECRET_KEY_BASE') { nil },
  private_key: ENV.fetch('SSH_PRIVATE_KEY') { nil },
  ssh_known_hosts: ENV.fetch('SSH_KNOW_HOSTS') { 'github.com bitbucket.org' },
  enable_auto_bundle: ENV.fetch('ENABLE_AUTO_GEMFILE') { false },
  enable_auto_migrate: ENV.fetch('ENABLE_AUTO_MIGRATE') { false }
}

# Setup SSH
if env[:private_key].to_s.size > 0 && env[:ssh_known_hosts].to_s.size > 0
  ssh = Config::Ssh.new(env[:user])
  # Install Private Key
  ssh.install_private_key(env[:private_key])
  # Set known_hosts
  ssh.set_known_hosts(env[:ssh_known_hosts])
end

# Check Gemfile and if necessary run bundle install
if env[:enable_auto_bundle].to_s == 'true'
  Config::Gemfile.new(env[:app_home], env[:rails_env]).check
end

# Setup migrate
if env[:enable_auto_migrate].to_s == 'true'
  Config::Migrate.new.db_create
  Config::Migrate.new.db_migrate
end