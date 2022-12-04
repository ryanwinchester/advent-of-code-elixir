Mix.install([
  {:benchee, "~> 1.0"}
])

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

input =
  "./range.member-input.txt"
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
      Enum.reduce(input, 0, fn {a, b}, count ->
        cond do
          OriginalMember.member?(b, a.first) == {:ok, true} -> count + 1
          OriginalMember.member?(a, b.first) == {:ok, true} -> count + 1
          true -> count
        end
      end)
    end,

    # The proposed `member?` implementation.
    "NewMember" => fn ->
      Enum.reduce(input, 0, fn {a, b}, count ->
        cond do
          NewMember.member?(b, a.first) == {:ok, true} -> count + 1
          NewMember.member?(a, b.first) == {:ok, true} -> count + 1
          true -> count
        end
      end)
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
# Estimated total run time: 28 s
#
# Benchmarking Enumerable ...
# Benchmarking NewMember ...
# Benchmarking OriginalMember ...
# Benchmarking in ...
#
# Name                     ips        average  deviation         median         99th %
# NewMember            1107.57        0.90 ms     ±5.79%        0.89 ms        1.08 ms
# OriginalMember        659.54        1.52 ms     ±4.27%        1.50 ms        1.70 ms
# in                    525.07        1.90 ms     ±4.07%        1.89 ms        2.11 ms
# Enumerable            492.61        2.03 ms    ±17.31%        2.01 ms        2.50 ms
#
# Comparison:
# NewMember            1107.57
# OriginalMember        659.54 - 1.68x slower +0.61 ms
# in                    525.07 - 2.11x slower +1.00 ms
# Enumerable            492.61 - 2.25x slower +1.13 ms
