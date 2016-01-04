defmodule Example do
    def func do
        alias Mix.Tasks.DocTest, as: Doctest
        doc = Doctest.setup
        doc.run(Doctest.defaults)
    end
end
