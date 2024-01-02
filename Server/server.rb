require 'socket'
require './users'
require './user'

server = TCPServer.new(40000)

puts "Server is running on port 40000"

users = Users.new

while true
    tcp_socket = server.accept
    Thread.new(tcp_socket) do |socket|
        user = users.register(socket)
        begin
            users.start_listening_to(user)
        rescue EOFError
            users.disconnect(user)
        end
    end
end
