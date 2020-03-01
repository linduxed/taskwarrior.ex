# Taskwarrior

This library aims to make it easier to work with the output from Taskwarrior's
`task export` command.

Currently the main purpose of the library is to convert the `task export` JSON
data into a named struct. Eventually, the library is expected to grow with the
introduction of various functions for traversing/editing the data.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `taskwarrior` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:taskwarrior, "~> 0.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/taskwarrior](https://hexdocs.pm/taskwarrior).
