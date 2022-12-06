# ------------------------------------------------------------------------------
# Enum.uniq/1
# ------------------------------------------------------------------------------
defmodule Day06.Uniq do
  def part_2(buffer), do: marker_index(buffer, 14)

  defp marker_index(buffer, marker_length) do
    buffer
    |> String.codepoints()
    |> Enum.chunk_every(marker_length, 1)
    |> get_marker_index()
  end

  defp get_marker_index([check | rest], index \\ 0) do
    if has_marker?(check) do
      length(check) + index
    else
      get_marker_index(rest, index + 1)
    end
  end

  defp has_marker?(check), do: Enum.uniq(check) == check
end

# ------------------------------------------------------------------------------
# MapSet.new() |> MapSet.size()
# ------------------------------------------------------------------------------
defmodule Day06.MapSet do
  def part_2(buffer), do: marker_index(buffer, 14)

  defp marker_index(buffer, marker_length) do
    buffer
    |> String.codepoints()
    |> Enum.chunk_every(marker_length, 1)
    |> get_marker_index()
  end

  defp get_marker_index([check | rest], index \\ 0) do
    if has_marker?(check) do
      length(check) + index
    else
      get_marker_index(rest, index + 1)
    end
  end

  defp has_marker?(check), do: (MapSet.new(check) |> MapSet.size()) == 14
end

# ------------------------------------------------------------------------------
# Bitwise
# ------------------------------------------------------------------------------
defmodule Day06.Bitwise do
  import Bitwise

  def part_2(buffer), do: marker_index(buffer, 14)

  defp marker_index(buffer, marker_length) do
    buffer
    |> String.to_charlist()
    |> Enum.chunk_every(marker_length, 1)
    |> get_marker_index(marker_length)
  end

  # Check the chunks...
  defp get_marker_index([check | rest], marker_length, index \\ 0) do
    if unique_chunk?(check) do
      marker_length + index
    else
      get_marker_index(rest, marker_length, index + 1)
    end
  end

  # Start the recursion.
  defp unique_chunk?([c | rest]), do: unique_chunk?(rest, 1 <<< (c - ?a))

  # When there are no more chars and it was never false, it must be unique?
  defp unique_chunk?([], _prev), do: true

  # Do the stuff.
  defp unique_chunk?([c | rest], prev) do
    data = prev ||| (1 <<< (c - ?a))
    if data == prev, do: false, else: unique_chunk?(rest, data)
  end
end

# ------------------------------------------------------------------------------
# Benchmarks
# ------------------------------------------------------------------------------

input =
  "../test/support/inputs/advent_2022/06.txt"
  |> Path.expand(__DIR__)
  |> File.read!()

Benchee.run(
  %{
    "Enum.uniq/1" => fn -> Day06.Uniq.part_2(input) end,
    "MapSet" => fn -> Day06.MapSet.part_2(input) end,
    "Bitwise" => fn -> Day06.Bitwise.part_2(input) end
  },
  time: 5,
  memory_time: 2
)

# ------------------------------------------------------------------------------
# Results
# ------------------------------------------------------------------------------

# ❯ mix run bench/day06.exs
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
# memory time: 2 s
# reduction time: 0 ns
# parallel: 1
# inputs: none specified
# Estimated total run time: 27 s
#
# Benchmarking Bitwise ...
# Benchmarking Enum.uniq/1 ...
# Benchmarking MapSet ...
#
# Name                  ips        average  deviation         median         99th %
# Bitwise            802.27        1.25 ms    ±16.49%        1.26 ms        1.83 ms
# MapSet             211.50        4.73 ms     ±9.95%        4.61 ms        5.79 ms
# Enum.uniq/1        147.98        6.76 ms     ±6.01%        6.87 ms        7.53 ms
#
# Comparison:
# Bitwise            802.27
# MapSet             211.50 - 3.79x slower +3.48 ms
# Enum.uniq/1        147.98 - 5.42x slower +5.51 ms
#
# Memory usage statistics:
#
# Name           Memory usage
# Bitwise             2.23 MB
# MapSet              3.41 MB - 1.52x memory usage +1.17 MB
# Enum.uniq/1         6.32 MB - 2.83x memory usage +4.09 MB
#
# **All measurements for memory usage were the same**
