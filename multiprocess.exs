defmodule MultiProcess do
    def run do
        generate(:fred)
        generate(:betty)
    end

    def test_process(client) do
        receive do
            token ->
                send(client, token)
        end
    end

    def generate(token) do
        p = spawn(MultiProcess, :test_process, [self])
        send(p, token)
        receive do
            response -> IO.puts(inspect(response))
        end
    end
end
