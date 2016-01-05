require 'socket'
require 'hurley'

class Server

  def initialize(port = 9292)
    @server = TCPServer.new(9292)
    @n = -1
  end

  def request_response(server = @server)
    while (@client = server.accept)
      request_format = request(@client)
      response(request_format)
    end
  end
end

class Request < Server

  def request(client)
    request_lines = []
    while line = @client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end

    verb = request_lines[0].split[0]
    path = request_lines[0].split[1]
    protocol = request_lines[0].split[2]
    host = request_lines[1].split(":")[1].strip
    port = request_lines[1].split(":").last
    accept = request_lines[4].split(":")[1].strip

    request_format = ["Verb: #{verb}",
      "Path: #{path}",
      "Protocol: #{protocol}",
      "Host: #{host}",
      "Port: #{port}",
      "Origin: #{host}",
      "Accept: #{accept}"]
    request_format
  end
end

class Response < Request
  def response(request_format)
    response = "<pre>" + request_format.join("\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"

    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n"),
              "Hello, World! (#{@n += 1})"
    @client.puts headers
    @client.puts output
  end
end

server = Response.new
server.request_response
