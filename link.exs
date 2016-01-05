defmodule Link1 do
    import :timer, only: [sleep: 1]

    def sad_function do
        sleep 500
        exit(:boom)
    end

    def run do
        Process.flag(:trap_exit, true)
        spawn(Link, :sad_function, [])
        receive do
            msg ->
                IO.puts "MESSAGE RECEIVED: #{inspect msg}"
        after 1000 ->
            IO.puts "Nothing happened as far as I'm concerned"
        end
    end
end

defmodule Link2 do
    import :timer, only: [sleep: 1]

    def sad_function do
        sleep 500
        exit(:boom)
    end

    def run do
        spawn_link(Link2, :sad_function, [])
        receive do
            msg ->
                IO.puts "MESSAGE RECEIVED: #{inspect msg}"
        after 1000 ->
            IO.puts "Nothing happened as far as I'm concerned"
        end
    end
end

defmodule Link3 do
    import :timer, only: [sleep: 1]

    def sad_function do
        sleep 500
        exit(:boom)
    end

    def run do
        Process.flag(:trap_exit, true)
        spawn_link(Link3, :sad_function, [])
        receive do
            msg ->
                IO.puts "MESSAGE RECEIVED: #{inspect msg}"
        after 1000 ->
            IO.puts "Nothing happened as far as I'm concerned"
        end
    end
end

defmodule Link4 do
    def message(sender) do
        send sender, "Message"
        exit "That's all for now"
    end

    def check_for_message do
        receive do
            msg ->
                IO.puts "Received a message: #{inspect msg}"
                check_for_message
        after 500 ->
            IO.puts "No more messages"
        end
    end

    def run do
        Process.flag(:trap_exit, true)
        res = spawn_link(Link4, :message, [self])
        IO.puts inspect res
        :timer.sleep 500
        check_for_message
    end
end
