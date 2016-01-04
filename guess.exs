defmodule Chop do
    def guess(actual, range = low..high) do
        guess = div(low + high, 2)
        IO.puts "Is is #{guess}?"
        _guess(guess, actual, range)
    end

    def _guess(actual, actual, _) do
        IO.puts "Yes, it is #{actual}!"
    end

    def _guess(guess, actual, low.._high) when guess > actual do
        guess(actual, low..guess - 1)
    end

    def _guess(guess, actual, _low..high) when guess < actual do
        guess(actual, guess + 1..high)
    end
end

Chop.guess(254, 1..500)
