defmodule NewMember do
  @moduledoc "With the proposed new functions."
  def member?(first..last//1, value) when first <= last and is_integer(value) do
    {:ok, first <= value and value <= last}
  end

  def member?(first..last//-1, value) when last <= first and is_integer(value) do
    {:ok, last <= value and value <= first}
  end

  def member?(first..last//1, _) when first > last, do: {:ok, false}
  def member?(first..last//-1, _) when first < last, do: {:ok, false}
end

defmodule OriginalMember do
  @moduledoc "With the original function."
  def member?(first..last//step = range, value) when is_integer(value) do
    cond do
      Range.size(range) == 0 ->
        {:ok, false}

      first <= last ->
        {:ok, first <= value and value <= last and rem(value - first, step) == 0}

      true ->
        {:ok, last <= value and value <= first and rem(value - first, step) == 0}
    end
  end
end

defmodule OptimizedMember do
  @moduledoc "With the original function."
  def member?(first..last//step, value) when is_integer(value) do
    if step > 0 do
      {:ok, first <= value and value <= last and rem(value - first, step) == 0}
    else
      {:ok, last <= value and value <= first and rem(value - first, step) == 0}
    end
  end
end

input =
  "./range.member-extended-input.txt"
  |> Path.expand(__DIR__)
  |> File.read!()
  |> String.split("\n", trim: true)
  |> Enum.map(fn pair ->
    pair
    |> String.split(",")
    |> Enum.map(fn range_str ->
      [a, b] = String.split(range_str, "-")
      Range.new(String.to_integer(a), String.to_integer(b))
    end)
    |> List.to_tuple()
  end)

:eprof.start()

# Comparing `value in range` vs `value >= range.first and value <= range.last`.
Benchee.run(
  %{
    "in" => fn ->
      Enum.reduce(input, 0, fn {a, b}, count ->
        cond do
          a.first in b -> count + 1
          b.first in a -> count + 1
          true -> count
        end
      end)
    end,

    "Enumerable" => fn ->
      Enum.reduce(input, 0, fn {a, b}, count ->
        cond do
          Enumerable.member?(b, a.first) == {:ok, true} -> count + 1
          Enumerable.member?(a, b.first) == {:ok, true} -> count + 1
          true -> count
        end
      end)
    end,

    # The original `member?` implementation, to avoid Protocol dispatch.
    "OriginalMember" => fn ->
      :eprof.profile(fn ->
      Enum.reduce(input, 0, fn {a, b}, count ->
        cond do
          OriginalMember.member?(b, a.first) == {:ok, true} -> count + 1
          OriginalMember.member?(a, b.first) == {:ok, true} -> count + 1
          true -> count
        end
      end)
      end)
      :eprof.analyze()
    end,

    "OptimizedMember" => fn ->
      :eprof.profile(fn ->
      Enum.reduce(input, 0, fn {a, b}, count ->
        cond do
          OptimizedMember.member?(b, a.first) == {:ok, true} -> count + 1
          OptimizedMember.member?(a, b.first) == {:ok, true} -> count + 1
          true -> count
        end
      end)
      end)
      :eprof.analyze()
    end,

    # The proposed `member?` implementation.
    "NewMember" => fn ->
      :eprof.profile(fn ->
      Enum.reduce(input, 0, fn {a, b}, count ->
        cond do
          NewMember.member?(b, a.first) == {:ok, true} -> count + 1
          NewMember.member?(a, b.first) == {:ok, true} -> count + 1
          true -> count
        end
      end)
      end)
      :eprof.analyze()
    end
  }
)

# ❯ elixir bench/extras/range.member.exs
# Operating System: macOS
# CPU Information: Intel(R) Core(TM) i5-9600K CPU @ 3.70GHz
# Number of Available Cores: 6
# Available memory: 32 GB
# Elixir 1.14.2
# Erlang 25.1.2
#
# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: none specified
# Estimated total run time: 35 s
#
# Benchmarking Enumerable ...
# Benchmarking NewMember ...
# Benchmarking OptimizedMember ...
# Benchmarking OriginalMember ...
# Benchmarking in ...
#
# Name                      ips        average  deviation         median         99th %
# NewMember             1124.24        0.89 ms     ±6.55%        0.88 ms        1.04 ms
# OptimizedMember       1051.91        0.95 ms     ±5.10%        0.94 ms        1.10 ms
# OriginalMember         674.34        1.48 ms     ±3.10%        1.48 ms        1.62 ms
# in                     525.43        1.90 ms     ±3.17%        1.90 ms        2.06 ms
# Enumerable             512.84        1.95 ms     ±3.08%        1.94 ms        2.11 ms
#
# Comparison:
# NewMember             1124.24
# OptimizedMember       1051.91 - 1.07x slower +0.0612 ms
# OriginalMember         674.34 - 1.67x slower +0.59 ms
# in                     525.43 - 2.14x slower +1.01 ms
# Enumerable             512.84 - 2.19x slower +1.06 ms
