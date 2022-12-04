Mix.install([{:benchee, "~> 1.0"}])

sections =
  "../test/support/inputs/2022/day-04.txt"
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

# Comparing `value in range` vs `value >= range.first and value <= range.last`.
Benchee.run(
  %{
    "range in" => fn ->
      Enum.reduce(sections, 0, fn {a, b}, count ->
        cond do
          a.first in b and a.last in b -> count + 1
          b.first in a and b.last in a -> count + 1
          true -> count
        end
      end)
    end,

    "range compare first-last" => fn ->
      Enum.reduce(sections, 0, fn {a, b}, count ->
        cond do
          a.first >= b.first and a.last <= b.last -> count + 1
          b.first >= a.first and b.last <= a.last -> count + 1
          true -> count
        end
      end)
    end
  }
)

# ❯ mix run bench/day04.exs
# Operating System: macOS
# CPU Information: Intel(R) Core(TM) i5-9600K CPU @ 3.70GHz
# Number of Available Cores: 6
# Available memory: 32 GB
# Elixir 1.14.2
# Erlang 25.1.2

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: none specified
# Estimated total run time: 14 s

# Benchmarking range compare first-last ...
# Benchmarking range in ...

# Name                               ips        average  deviation         median         99th %
# range compare first-last       22.95 K       43.57 μs    ±12.98%       42.52 μs       65.20 μs
# range in                        4.93 K      203.04 μs    ±44.59%      196.77 μs      262.83 μs

# Comparison:
# range compare first-last       22.95 K
# range in                        4.93 K - 4.66x slower +159.48 μs
