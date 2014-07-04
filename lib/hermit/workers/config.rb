require 'sidekiq'
require 'sidekiq-limit_fetch'

Sidekiq.configure_client do |config|
  config.redis = { :namespace => 'hermit_client', :size => 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { :namespace => 'hermit_client' }
  config.options[:queues] = ["google_search", "bing_search", "outbound_data"]
  config.options[:concurrency] = 25
  config.options[:verbose] = true
  config.options[:pidfile] = "tmp/pids/sidekiq.pid"
end

Sidekiq::Queue['google_search'].limit = 1
Sidekiq::Queue['bing_search'].limit = 1

Dir.glob("*_worker.rb") { |filename| require filename }
