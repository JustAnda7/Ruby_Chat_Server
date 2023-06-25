class User

    attr_reader :username, :socket

    def initialize(username, socket)
        @username = username
        @socket = socket
    end

    def welcome_from(users)
        socket.print "Welcome, #{username}! There are #{users.count} people in the room!"
        newline_prompt
    end

    def prompt
        socket.print ">"
    end

    def newline_prompt
        socket.print "\n>"
    end

    def listen
        socket.readline.chomp
    end

    def disconnect
        socket.close
    end
end