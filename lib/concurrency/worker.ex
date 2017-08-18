defmodule Concurrency.Worker do
  # Public API
  def start() do
    spawn(__MODULE__, :do_work, [10])
  end

  def decrement(pid) do
    send(pid, :decrement)
  end

  def current(pid) do
    send(pid, {:current, self()})

    receive do
      count when is_integer(count) -> count
    end
  end

  # Implementation

  def do_work(0) do
    IO.inspect("done!")
  end

  def do_work(count) when count > 0 do
    receive do
      :decrement ->
        IO.inspect("Count: #{inspect count - 1}")
        do_work(count - 1)
      {:current, sender} ->
        send(sender, count)
        do_work(count)
      _ ->
        IO.inspect("Count: #{inspect count}")
        do_work(count)
    end
  end
end
