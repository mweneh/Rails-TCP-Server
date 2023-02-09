# Rails-TCP-Server
This is a Ruby TCP server that can accept and hold a maximum of N clients (where N is configurable). Clients are assigned ranks based on first-come-first-serve, i.e. whoever connects first receives the next available high rank. Ranks are from 0 to N, where 0 is the highest rank.

Clients can send commands to the server that the server distributes among the clients. Only a client with a lower rank can execute a command of a higher rank client. Higher rank clients cannot execute commands from lower rank clients, so these commands are rejected. The command execution can be as simple as the client printing to console that the command has been executed.

If a client disconnects, the server re-adjusts the ranks and promotes any client that needs to be promoted not to leave any gaps in the ranks.
Usage

    Clone the repository to your local machine.



$ git clone https://github.com/mweneh/Rails-TCP-Server.git

    Navigate to the repository directory.



$ cd  Rails-TCP-Server

    Start the server by running the server.rb file.

ruby

$ ruby server.rb

    Connect to the server using a client. The example client code is provided below. Replace the host and port variables with the appropriate values for your server.

ruby

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

client.close

Available commands

    EXECUTE - Execute a command on a client.
    DISCONNECT - Disconnect from the server.

License

This project is licensed under the MIT License. See the LICENSE file for details.
