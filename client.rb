require 'socket'

host = 'localhost'
port = 3002

client = TCPSocket.new(host, port)

puts client.gets.strip

loop do
    message = gets.strip
    client.puts message
  
    case message
    when 'EXECUTE'
      puts client.gets.strip
    when 'DISCONNECT'
      break
    else
      puts "Unknown command: #{message}"
    end
  end