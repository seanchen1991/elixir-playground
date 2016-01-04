defmodule MyList do
    def len([]), do: 0
    def len([_head|tail]), do: 1 + len(tail)

    def square([]), do: []
    def square([head|tail]) do
        [head*head|square(tail)]
    end

    def add_one([]), do: []
    def add_one([head|tail]) do
        [head + 1|add_one(tail)]
    end

    def map([], _func), do: []
    def map([head|tail], func) do
        [func.(head)|map(tail, func)]
    end

    def sum_list([]), do: 0
    def sum_list([head|tail]) do
        head + sum_list(tail)
    end

    def reduce([], value, _func), do: value
    def reduce([head|tail], value, func) do
        reduce(tail, func.(head, value), func)
    end

    def mapsum(list, func) do
        map(list, func) |> sum_list
    end

    def max([x]), do: x
    def max([head|tail]), do: Kernel.max(head, max(tail))

    def caesar([], _n), do: []
    def caesar([head|tail], n)
        when head + n <= ?z,
        do: [head + n|caesar(tail, n)]

    def caesar([head|tail], n) do
        [head + n - 26|caesar(tail, n)]
    end

    def span([], _to), do: []
    def span([head|tail], to)
        when head <= to,
        do: [head|span(tail, to)]

    def span([_head|tail], to) do
        span(tail, to)
    end

    def primes(n) do
        range = span(2, n)
        range -- (lc a inlist range, b inlist range, a <= b, a * b <= n, do: a * b)
    end
end
