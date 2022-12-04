input =
  "./range.member-input.txt"
  |> Path.expand(__DIR__)
  |> File.read!()

Benchee.run(
  %{
    "NimbleParsec" => fn ->
      Advent2022.Day04Parser.input(input)
    end,

    "split/map" => fn ->
      input
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
    end
  }
)

# ❯ mix run bench/extras/parsec_vs_enum.exs
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
# Benchmarking NumbleParsec ...
# Benchmarking split/map ...
#
# Name                   ips        average  deviation         median         99th %
# NimbleParsec         92.16       10.85 ms    ±13.75%       10.85 ms       14.30 ms
# split/map            46.09       21.70 ms     ±7.58%       21.40 ms       26.04 ms
#
# Comparison:
# NumbleParsec         92.16
# split/map            46.09 - 2.00x slower +10.85 ms
