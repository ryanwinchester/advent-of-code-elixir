{:ok, input, _, _, _, _} =
  "../test/support/inputs/2022/day-04.txt"
  |> Path.expand(__DIR__)
  |> File.read!()
  |> Advent2022.Day04Parser.input()

# Comparing `value in range` vs `value >= range.first and value <= range.last`.
Benchee.run(
  %{
    "range in" => fn ->
      Enum.reduce(input, 0, fn {a, b}, count ->
        cond do
          a.first in b and a.last in b -> count + 1
          b.first in a and b.last in a -> count + 1
          true -> count
        end
      end)
    end,

    "range compare first-last" => fn ->
      Enum.reduce(input, 0, fn {a, b}, count ->
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
#
# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: none specified
# Estimated total run time: 14 s
#
# Benchmarking compare fist-last ...
# Benchmarking range in ...
#
# Name                        ips        average  deviation         median         99th %
# compare fist-last       22.81 K       43.84 μs    ±12.55%       42.80 μs       64.04 μs
# range in                 5.00 K      200.06 μs     ±5.16%      196.34 μs      244.32 μs
#
# Comparison:
# compare fist-last       22.81 K
# range in                 5.00 K - 4.56x slower +156.22 μs
