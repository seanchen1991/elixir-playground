fizzbuzz = fn
    0, 0, _ -> "FizzBuzz"
    0, _, _ -> "Fizz"
    _, 0, _ -> "Buzz"
    _, _, n -> n
end

func = fn n ->
    fizzbuzz.(rem(n,3), rem(n,5), n)
end

IO.puts func.(10)
IO.puts func.(11)
IO.puts func.(12)
IO.puts func.(13)
IO.puts func.(14)
IO.puts func.(15)
IO.puts func.(16)
