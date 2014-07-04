require 'sidekiq'
require 'Hermit/web/browser'
require 'Hermit/web/search'
require 'Hermit/workers/outbound_delivery_worker'

class GoogleSearchWorker
	include Sidekiq::Worker
	sidekiq_options  :queue => :google_search, :retry => false   

	# @param [Array] keywords
	# @param [Integer] pages
	def perform(keywords, pages)
		firefox = Browser.new
		keywords.each do |keyword|
			google_search = Search.new(keyword, firefox, engine: 'Google', pages: pages)
			google_search.do_search
			OutboundDeliveryWorker.perform_async('Search', google_search.results)
		end
		firefox.close
	end
end