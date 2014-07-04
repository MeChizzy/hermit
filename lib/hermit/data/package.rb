require 'jsonable'

class Package
	include Jsonable
	attr_accessor :data
	
	def initialize(args)
		@data = []
		args.each { |arg| @data << arg }
	end
end