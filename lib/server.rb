require 'socket'
require 'hurley'
require 'request'
require 'diagnostics_formatter'
require 'response'

class Server
  def initialize(port = 9292)
    @port = port
    @server = TCPServer.new(port)
  end

  def request_response(server = @server, port = @port)
    total_requests = 0
    hello_world_count = 0
    while (client = server.accept)
      request_object = Request.new(client)
      Response.new(request_object, port, total_requests, hello_world_count)
      total_requests += 1
      if request_object.request_lines_hash["Path:"] == "/hello"
        hello_world_count += 1
      end
      
      break if request_object.request_lines_hash["Path:"] == "/shutdown"
    end
    puts "Total requests: #{total_requests - 1}"
    client.close
  end
end
