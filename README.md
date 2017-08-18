# Concurrency

A small app which just creates a worker process that holds an integer as state
that can be decremented.

## Using

The worker's code is found in `./lib/concurrency/worker.ex`

To start the REPL:

```bash
mix compile;
iex -S mix;
```

In your REPL:

```elixir
pid = Concurrency.Worker.start()

Concurrency.Worker.decrement(pid)
Concurrency.Worker.current(pid)
Concurrency.Worker.decrement(pid)
Concurrency.Worker.decrement(pid)
Concurrency.Worker.current(pid)
```

When the counter is decremented to 0, the process terminates and cleans itself
up.

## Extra Credit
1. Modify the `start` function to accept a starting value for the counter,
defaulting to 10.
1. Modify the `receive` block in `current/1` to time out after 5 seconds,
	 returning `{:error, :timeout}` in that case.
1. Create an `increment/1` function, which behaves like `decrement/1` does, but
	 increments the counter instead of decrementing it.
