# Convert a float to a string with two decimal digits
:io.format("~.2f~n", [2.0/3.0])

# Get the value of an operating system environment variable
System.get_env("HOME")

# Return the extension component of a file name
Path.extname("dave/test.exs")

# Return the process's current working directory
System.cwd

# Convert a string containing JSON into Elixir data structures
"""
There are many options. Some, such as https://github.com/guedes/exjson, are
specifically for Elixir. Others, such as https://github.com/hio/erlang-js are
Erlang libraries that are usable from Elixir.
"""

# Execute a command in your operating system's shell
System.cmd(command, args, opts \\ [])
