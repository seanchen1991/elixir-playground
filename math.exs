defmodule Math do
    def zero?(0), do: true
    def zero?(x) when is_number(x), do: false
end
