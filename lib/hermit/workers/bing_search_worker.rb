require 'sidekiq'
require 'Hermit/web/browser'
require 'Hermit/web/search'
require 'Hermit/workers/outbound_delivery_worker'

class BingSearchWorker
	include Sidekiq::Worker
	sidekiq_options  :queue => :bing_search, :retry => false   

	# @param [Array] keywords
	# @param [Integer] pages
	def perform(keywords, pages)
		firefox = Browser.new
		keywords.each do |keyword|
			bing_search = Search.new(keyword, firefox, engine: 'Bing', pages: pages)
			bing_search.do_search
			OutboundDeliveryWorker.perform_async('Search', bing_search.results)
		end
		firefox.close
	end
end