# Sidekiq.configure_server do |config|
#   config.redis = { url: ENV['REDIS_PROVIDER'] }
# end
#
# Sidekiq.configure_client do |config|
#   config.redis = { url: ENV['REDIS_PROVIDER'] }
# end
#
# Sidekiq::Cron::Job.load_from_hash YAML.load_file('config/schedule.yml') if Sidekiq.server?
# inside config/initializers/sidekiq.rb

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
end
Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
end
