defmodule HotelRoom do
    def book(%{name: name, height: height})
        when height > 1.9,
        do: IO.puts "Need extra long bed for #{name}"

    def book(%{name: name, height: height})
        when height < 1.3,
        do: IO.puts "Need lower shower controls for #{name}"

    def book(person), do: IO.puts "Need regular bed for #{person.name}"
end
