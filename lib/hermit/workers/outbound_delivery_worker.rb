require 'sidekiq'
require 'Hermit/data/package'
require 'Hermit/data/route'

class OutboundDeliveryWorker
	include Sidekiq::Worker
	sidekiq_options :queue => :outbound_data, :retry => false

	def perform(*args)
		package = Package.new(args)
		route	= Route.new(port: 6902)
		route.deliver(package)
	end
end