defmodule ParallelMap do
    def pmap(collection, func) do

        # Save the pid of the parent process
        # Without this, `self` will be pointing to the child processes
        # This will cause each spawned process to send a message to itself,
        # not the parent process
        me = self
        collection
        |> Enum.map(fn elem ->
            spawn_link fn -> (send me, { self, func.(elem) }) end
           end)
        |> Enum.map(fn pid ->
            receive do {^pid, result} -> result end
        end)
    end
end
