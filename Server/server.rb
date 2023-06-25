require 'socket'
require './users'

server = TCPServer.new(40000)

puts "Server is running on port 40000"

users = Users.new

while true
    tcp_socket = server.accept
    Thread.new(tcp_socket) do |socket|
        member = members.register(socket)
        begin
            members.start_listening_to(member)
        rescue EOFError
            members.disconnect(member)            
        end
    end
end
