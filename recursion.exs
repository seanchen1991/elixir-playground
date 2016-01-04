defmodule Factorial do
    def of(0), do: 1
    def of(n) when n > 0 do
        n * of(n-1)
    end
end

defmodule Sum do
    def of(0), do: 0
    def of(n), do: n + of(n - 1)
end

defmodule Gcd do
    def of(x, 0), do: x
    def of(x, y), do: of(y, rem(x, y))
end

defmodule Reduce do
    def of([], accumulator), do: accumulator
    def of([head|tail], accumulator) do
        of(tail, head + accumulator)
    end
end
