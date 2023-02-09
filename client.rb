require 'socket'

host = 'localhost'
port = 3002

client = TCPSocket.new(host, port)

puts client.gets.strip