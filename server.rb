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
        end
      end
end  