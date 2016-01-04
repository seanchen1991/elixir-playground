defmodule Mod do
    def func1 do
        IO.puts "in func1"
    end

    def func2 do
        func1
        IO.puts "in func2"
    end
end

defmodule Outer do
    defmodule Inner do
        def inner_func do
        end
    end

    def outer_func do
        Inner.inner_func
    end
end

defmodule Mix.Tasks.DocTest do
    def run do
    end
end

Outer.outer_func
Outer.Inner.inner_func
