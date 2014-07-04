require 'selenium-webdriver'

class Browser

	def initialize(browser = 'firefox')
		@driver = Selenium::WebDriver.for browser.downcase.to_sym
		@driver.manage.window.move_to(1300, 1400)
    @driver.manage.window.resize_to(500, 500)
    @driver.manage.timeouts.implicit_wait = 10 # seconds
	end

  def get_(what, args = {})
    look_for = what.downcase
    case look_for
      when "html"
        return @driver.page_source
      when "element"
        return @driver.find_element(args["how"], args["what"])
      when "elements"
        return @driver.find_elements(element["how"], element["what"])
      else
        return nil
    end
  end

  def visit(url)
    @driver.navigate.to url
  end

	def close
		@driver.quit
	end
end