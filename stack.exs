defmodule Stack.Server do
    use GenServer

    # External API
    def start_link(list) do
        GenServer.start_link(__MODULE__, list, name: __MODULE__)
    end

    def pop do
        GenServer.call(__MODULE__, :pop)
    end

    def push(element) do
        GenServer.cast(__MODULE__, {:push, element})
    end

    # GenServer implementation

    def handle_call(:pop, _from, [head|tail]) do
        { :reply, head, tail }
    end

    def handle_cast({:push, new_element}, list) do
        { :noreply, [new_element|list] }
    end

    def terminate(reason, list) do
        IO.puts "Terminating server: #{inspect reason}"
        IO.puts "Last known state: #{inspect list}"
    end
end

defmodule Stack do
    use Application

    def start(_type, _args) do
        import Supervisor.Spec, warn: false

        children = [
            worker(Stack.Server, [])
        ]

        opts = [
            strategy: :one_for_one,
            name: Stack.Supervisor
         ]

         {:ok, _pid} = Supervisor.start_link(children, opts)
    end
end
