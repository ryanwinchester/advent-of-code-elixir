Mix.install([{:benchee, "~> 1.0"}])

defmodule Example do
  def member?(first..last//1, value) when first <= last and is_integer(value) do
    {:ok, first <= value and value <= last}
  end

  def member?(first..last//-1, value) when last <= first and is_integer(value) do
    {:ok, last <= value and value <= first}
  end

  def member?(first..last//1, _) when first > last, do: {:ok, false}
  def member?(first..last//-1, _) when first < last, do: {:ok, false}
end

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
    "Enumerable" => fn ->
      Enum.reduce(sections, 0, fn {a, b}, count ->
        cond do
          Enumerable.member?(b, a.first) == {:ok, true} -> count + 1
          Enumerable.member?(a, b.first) == {:ok, true} -> count + 1
          true -> count
        end
      end)
    end,

    "Example" => fn ->
      Enum.reduce(sections, 0, fn {a, b}, count ->
        cond do
          Example.member?(b, a.first) == {:ok, true} -> count + 1
          Example.member?(a, b.first) == {:ok, true} -> count + 1
          true -> count
        end
      end)
    end
  }
)

# ❯ elixir bench/range.member.exs
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

# Benchmarking Enumerable ...
# Benchmarking Example ...

# Name                 ips        average  deviation         median         99th %
# Example          19.08 K       52.41 μs    ±11.31%       51.14 μs       75.67 μs
# Enumerable        8.42 K      118.79 μs     ±7.58%      115.89 μs      160.90 μs

# Comparison:
# Example          19.08 K
# Enumerable        8.42 K - 2.27x slower +66.38 μs
