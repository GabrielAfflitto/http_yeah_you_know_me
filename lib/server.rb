require 'socket'
require 'hurley'
require 'request'
require 'request_formatter'
require 'response'


class Server
  attr_reader :port

  def initialize(port = 9292)
    @port = port
    @server = TCPServer.new(9292)
    @total_requests = -1
  end

  def request_response(server = @server)
    while (client = server.accept)

      request_object = Request.new(client)
      #returns formatted string
      request_format =  RequestFormatter.new(request_object).request_format

      Response.new(request_object, request_format, client, @total_requests)
      @total_requests += 1
    end
  end
end
