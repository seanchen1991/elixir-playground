defmodule Map do
    def double_each([head|tail]) do
        [head * 2|double_each(tail)]
    end

    def double_each([]) do
        []
    end
end

defmodule Reduce do
    def sum_all([head|tail], accumulator) do
        sum_all(tail, head + accumulator)
    end

    def sum_all([], accumulator) do
        accumulator
    end
end
