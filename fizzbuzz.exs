defmodule FizzBuzz1 do
    def upto(n) when n > 0 do
        1..n |> Enum.map(&fizzbuzz/1)
    end

    defp fizzbuzz(n) do
        cond do
            rem(n, 3) == 0 and rem(n, 5) == 0 -> "FizzBuzz"
            rem(n, 3) -> "Fizz"
            rem(n, 5) -> "Buzz"
            true -> n
        end
    end
end

defmodule FizzBuzz2 do
    def upto(n) when n > 0 do
        1..n |> Enum.map(&fizzbuzz/1)
    end

    defp fizzbuzz(n)
        when rem(n, 5) == 0 and rem(n, 3) == 0,
        do: "FizzBuzz"

    defp fizzbuzz(n)
        when rem(n, 3) == 0,
        do: "Fizz"

    defp fizzbuzz(n)
        when rem(n, 5) == 0,
        do: "Buzz"

    defp fizzbuzz(n), do: n
end


defmodule FizzBuzz3 do
    def upto(n) when n > 0 do
        1..n |> Enum.map(&fizzbuzz/1)
    end

    defp fizzbuzz(n) do
        case { rem(n, 3), rem(n, 5), n } do
            {0, 0, _} -> "FizzBuzz"
            {0, _, _} -> "Fizz"
            {_, 0, _} -> "Buzz"
            {_, _, n} -> n
        end
    end
end
