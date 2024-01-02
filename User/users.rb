class Users
    include Enumerable

    def initialize()
        @users = []
    end

    def each
        @users.each { |user| yield user}
    end

    def add(user)
        @users << user
    end

    def remove(user)
        @users.delete(user)
    end

    def broadcast(message, sender)
        receivers = @users
        receivers.each do |receiver|
            receiver.socket.print "#{sender.username}: #{message}"
            receiver.newline_prompt
        end
    end

    def register(socket)
        username = get_user_info(socket)
        user = User.new(username, socket)
        user.welcome_from(self)
        add(user)
        broadcast("[joined]", user)
        user
    end

    def start_listening_to(user)
        loop do
            message = user.listen
            broadcast(message, user)
            user.prompt
        end
    end

    def disconnect(user)
        broadcast("[left]", user)
        user.disconnect
        remove(user)
    end

    private

    def get_user_info(socket)
        socket.print "Enter a Username"
        username = socket.gets.chomp
    end

end
