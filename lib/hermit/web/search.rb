require 'nokogiri'
require 'Hermit/web/search_config'

class Search

	attr_reader :results

	def initialize(keyword, browser, engine: 'google', pages: 1 )
		@keyword = keyword
		@engine = engine.downcase
		@pages = pages
		@browser = browser
		@provider_url = "http://#{ @engine }.com"
		@results = {}
		@elements = SearchConfig.engines[@engine]["elements_of_interest"]
		initialize_results
	end

	def do_search
		@browser.visit(@provider_url)
		type_search_query
		parse_and_set_results
	end

	private

	def initialize_results
		@results.store( "engine", @engine)
		@results.store( "keyword", @keyword)
		@results.store( "predictions", []) 
		@results.store( "results_html", [])
	end

	def type_search_query
		search_field = get_search_field
		type_keyword_in(search_field)
		press_enter_key(search_field)	
	end

	def parse_and_set_results
		while @pages > 0 do
			wait(seconds: 2)
			@results["results_html"]  << parse(@browser.get_("html"))
			@pages -= 1
			click(@elements["next_page"]) if @pages > 0	
		end
	end

	def get_search_field
		search_field = @browser.get_("element", @elements["search_field"])
		search_field.clear()
		search_field	
	end

	def type_keyword_in(field)
		@keyword.each_char do |char|
		wait
		field.send_keys char
		wait
		build_and_store_predictions(char) unless char == " "
		end	
	end

	def press_enter_key(field)
		wait
		field.send_keys :enter
		wait
	end

	def build_and_store_predictions(char)
		predictions = []
		predict = @browser.get_("elements", @elements["predictions"])
		predict = @browser.get_("elements", @elements["alt_predictions"]) if predict.empty?
		predict.each { |prediction| predictions << prediction.text }
		@results["predictions"] << [char, predictions]
	end

	def wait(seconds: 0)
		sleep( seconds + rand() )
	end

	def parse(page_source)
		document = Nokogiri::HTML(page_source)
		remove_blacklisted_tags(document)
		remove_blacklisted_tag_attributes(document)
		document.to_xhtml
	end

	def remove_blacklisted_tags(document)
		document.traverse do |node|
			node.remove if blacklisted?("tags", node.name)
		end
	end

	def remove_blacklisted_tag_attributes(document)
		document.traverse do |node|
			next unless node.respond_to? :attributes
			attrs = node.attributes
   			attrs.each do |attribute|
				attr_name = attribute[0]
				node.remove_attribute(attr_name) if blacklisted?("tag_attributes", attr_name)
			end
		end
	end

	def click(element)
		@browser.get_("element", element).click
	end

	def blacklisted?(type, name)
		SearchConfig.blacklisted[type].each do |tag|
			return true if name.start_with?(tag)
		end
		false
	end
	
end