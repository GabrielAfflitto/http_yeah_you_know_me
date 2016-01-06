require 'minitest/autorun'
require 'minitest/pride'
require 'request_formatter'
require 'request'
require 'test_helper'

class RequestFormatterTest < Minitest::Test

  def test_we_can_pass_in_request_object
    request = Request.new(MyClient.new, 9292)
    formatter = RequestFormatter.new(request)
    assert_equal RequestFormatter, formatter.class
  end

  def test_verb_format
    request = Request.new(MyClient.new, 9292)
    formatter = RequestFormatter.new(request)
    assert_equal "Verb: GET", formatter.request_format[0]
  end

  def test_path_format
    request = Request.new(MyClient.new, 9292)
    formatter = RequestFormatter.new(request)
    assert_equal "Path: /", formatter.request_format[1]
  end

  def test_protocol_format
    request = Request.new(MyClient.new, 9292)
    formatter = RequestFormatter.new(request)
    assert_equal "Protocol: HTTP/1.1", formatter.request_format[2]
  end

  def test_host_format
    request = Request.new(MyClient.new, 9292)
    formatter = RequestFormatter.new(request)
    assert_equal "Host: 127.0.0.1", formatter.request_format[3]
  end

  def test_port_format
    request = Request.new(MyClient.new, 9292)
    formatter = RequestFormatter.new(request)
    assert_equal "Port: 9292", formatter.request_format[4]
  end

  def test_port_format
    request = Request.new(MyClient.new, 9292)
    formatter = RequestFormatter.new(request)
    assert_equal "Port: 9292", formatter.request_format[4]
  end

  def test_origin_format
    request = Request.new(MyClient.new, 9292)
    formatter = RequestFormatter.new(request)
    assert_equal "Origin: 127.0.0.1", formatter.request_format[5]
  end

  def test_accept_format
    request = Request.new(MyClient.new, 9292)
    formatter = RequestFormatter.new(request)
    assert_equal "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", formatter.request_format[6]
  end
end
