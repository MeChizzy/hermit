require 'socket'

class Route

	def initialize(host: 'localhost', port: 6901)
		@socket = TCPSocket.new(host, port)
	end

	def deliver(package)
		@socket.sendmsg(package.to_json)
	end

	def close
		@socket.close
	end

end