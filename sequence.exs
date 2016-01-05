defmodule Sequence.Server do
    use GenServer
    require Logger

    defmodule State do
        defstruct current_number: 0, stash_pid: nil, delta: 1
    end

    @vsn "0"

    ####
    # External API

    def start_link(stash_pid) do
        GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
    end

    def next_number do
        GenServer.call(__MODULE__, :next_number)
    end

    def increment_number(delta) do
        GenServer.cast(__MODULE__, {:increment_number, delta})
    end

    ####
    # GenServer implementation

    def init(stash_pid) do
        current_number = Sequence.Stash.get_value(stash_pid)
        {:ok, %State{current_number: current_number, stash_pid: stash_pid}}
    end

    def handle_call(:next_number, _from, state) do
        { :reply, state.current_number, %{state|current_number: state.current_number + state.delta} }
    end

    def handle_cast({:increment_number, delta}, state) do
        { :noreply, %{state|current_number: state.current_number + delta, delta: delta} }
    end

    def terminate(_reason, state) do
        Sequence.Stash.save_value(state.stash_pid, state.current_number)
    end

    def code_change("0", old_state = {current_number, stash_pid}, _extra) do
        new_state = %State{current_number: current_number, stash_pid: stash_pid, delta: 1}
        Logger.info("Changing code from 0 to 1")
        Logger.info(inspect(old_state))
        Logger.info(inspect(new_state))
        {:ok, new_state}
    end
end

defmodule Sequence.Supervisor do
    use Supervisor

    def start_link(initial_number) do
        result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_number])
        start_workers(sup, initial_number)
        result
    end

    def start_workers(sup, initial_number) do
        # Start the stash worker
        {:ok, stash} = Supervisor.start_child(sup, worker(Sequence.Stash, [initial_number]))
        # And then the Supervisor for the actual sequence server
        Supervisor.start_child(sup, supervisor(Sequence.SubSupervisor, [stash]))
    end

    def init(_) do
        supervise([], strategy: :one_for_one)
    end
end

defmodule Sequence.SubSupervisor do
    use Supervisor

    def start_link(stash_pid) do
        {:ok, _pid} = Supervisor.start_link(__MODULE__, stash_pid)
    end

    def init(stash_pid) do
        child_processes = [ worker(Sequence.Server, [stash_pid]) ]
        supervise(child_processes, strategy: :one_for_one)
    end
end

defmodule Sequence.Stash do
    use GenServer

    # External API
    def start_link(current_number) do
        {:ok, _pid} = GenServer.start_link(__MODULE__, current_number)
    end

    def save_value(pid, value) do
        GenServer.cast(pid, {:save_value, value})
    end

    def get_value(pid) do
        GenServer.call(pid, :get_value)
    end

    # GenServer implementation
    def handle_call(:get_value, _from, current_value) do
        { :reply, current_value, current_value }
    end

    def handle_cast({:save_value, value}, _current_value) do
        { :noreply, value }
    end
end

defmodule Sequence do
    use Application

    def start(_type, initial_number) do
        Sequence.Supervisor.start_link(initial_number)
    end
end
