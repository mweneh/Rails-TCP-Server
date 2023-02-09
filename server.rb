require 'socket'

class TcpServer
    attr_reader :clients, :max_clients
  
    def initialize(port, max_clients)
      @server = TCPServer.new(port)
      @clients = []
      @max_clients = max_clients
    end

    def start
        puts "Server started on port #{@server.addr[1]}"
    
        loop do
          client = @server.accept
    
          if @clients.count < @max_clients
            puts "Accepted connection from #{client.peeraddr[2]}"
            client.puts "Welcome! You have been assigned rank #{@clients.count}"
            @clients << client
            Thread.new { handle_client(client) }
          else
            puts "Rejected connection from #{client.peeraddr[2]}"
            client.puts "Sorry, the server is full."
            client.close
          end
        end

        def handle_client(client)
            rank = @clients.index(client)

            loop do
                message = client.gets.strip
                command, *params = message.split(' ')
          
                case command
                when 'EXECUTE'
                  execute_command(client, rank, params[0].to_i)
                when 'DISCONNECT'
                  disconnect_client(client, rank)
                  break
                else
                  puts "Unknown command from client #{rank}: #{message}"
                end
              end
        end

        def execute_command(client, rank, target_rank)
            if target_rank < rank
              client.puts "Command executed by client #{rank}"
              @clients[target_rank].puts "EXECUTED #{rank}"
            else
              client.puts "Command rejected by client #{rank}"
            end
          end

          def disconnect_client(client, rank)
            puts "Client #{rank} Disconnected!"
            @clients.delete(client)
            client.close

            @clients.each_with_index do |c, i|
                c.puts "PROMOTED TO RANK #{i}" if i > rank
              end
            end
          end 
      
end  