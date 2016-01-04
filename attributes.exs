defmodule Example1 do
    @author "Sean Chen"
    def get_author do
        @author
    end
end

defmodule Example2 do
    @attr "one"
    def first, do: @attr
    @attr "two"
    def second, do: @attr
end

IO.puts "Example was written by #{Example1.get_author}"
IO.puts "#{Example2.first} #{Example2.second}"
