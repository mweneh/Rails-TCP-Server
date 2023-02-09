class TcpServer
    attr_reader :clients, :max_clients
  
    def initialize(port, max_clients)
      @server = TCPServer.new(port)
      @clients = []
      @max_clients = max_clients
    end
end  