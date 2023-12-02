# ------------------------------------------------------------------------------
# Ryan
# ------------------------------------------------------------------------------
defmodule Day01.Ryan do
  def part_2(input) do
    input
    |> Advent.input_lines()
    |> Advent2023.Day01.part_2()
  end
end

# ------------------------------------------------------------------------------
# Brad
# ------------------------------------------------------------------------------
defmodule Day01.Brad do
  def part_2(input) do
    prepared =
      input
      |> String.replace("zero", "zero0zero")
      |> String.replace("one", "one1one")
      |> String.replace("two", "two2two")
      |> String.replace("three", "three3three")
      |> String.replace("four", "four4four")
      |> String.replace("five", "five5five")
      |> String.replace("six", "six6six")
      |> String.replace("seven", "seven7seven")
      |> String.replace("eight", "eight8eight")
      |> String.replace("nine", "nine9nine")

    Regex.replace(~r/[^\d\n]/, prepared, "")
    |> String.split()
    |> Enum.reduce(0, fn line, acc ->
      number = "#{String.first(line)}#{String.last(line)}"
      acc + String.to_integer(number)
    end)
  end
end

# ------------------------------------------------------------------------------
# Benchmarks
# ------------------------------------------------------------------------------

input_sm =
  "../../test/support/inputs/advent_2023/01.txt"
  |> Path.expand(__DIR__)
  |> File.read!()

input_md = String.duplicate(input_sm, 1000)
input_lg = String.duplicate(input_sm, 10_000)

Benchee.run(
  %{
    "Ryan" => fn input -> Day01.Ryan.part_2(input) end,
    "Brad" => fn input -> Day01.Brad.part_2(input) end
  },
  inputs: %{
    "sm" => input_sm,
    "md" => input_md,
    "lg" => input_lg,
  },
  time: 5,
  memory_time: 2
)

# ------------------------------------------------------------------------------
# Results
# ------------------------------------------------------------------------------

# ❯ mix run bench/advent_2023/day_01.exs
# Operating System: macOS
# CPU Information: Apple M2 Ultra
# Number of Available Cores: 24
# Available memory: 128 GB
# Elixir 1.15.7
# Erlang 26.1.2

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 2 s
# reduction time: 0 ns
# parallel: 1
# inputs: lg, md, sm
# Estimated total run time: 54 s

# ##### With input lg #####
# Name           ips        average  deviation         median         99th %
# Ryan          0.33     0.0510 min     ±0.66%     0.0510 min     0.0512 min
# Brad       0.00615       2.71 min     ±0.00%       2.71 min       2.71 min

# Comparison:
# Ryan          0.33
# Brad       0.00615 - 53.17x slower +2.66 min

# Memory usage statistics:

# Name    Memory usage
# Ryan         1.60 GB
# Brad        87.53 GB - 54.71x memory usage +85.93 GB

# ##### With input md #####
# Name           ips        average  deviation         median         99th %
# Ryan          3.23         0.31 s     ±2.75%         0.31 s         0.32 s
# Brad        0.0647        15.46 s     ±0.00%        15.46 s        15.46 s

# Comparison:
# Ryan          3.23
# Brad        0.0647 - 49.94x slower +15.15 s

# Memory usage statistics:

# Name    Memory usage
# Ryan        0.160 GB
# Brad         8.73 GB - 54.56x memory usage +8.57 GB

# ##### With input sm #####
# Name           ips        average  deviation         median         99th %
# Ryan        3.90 K        0.26 ms    ±12.61%        0.25 ms        0.35 ms
# Brad      0.0810 K       12.35 ms     ±6.46%       12.21 ms       14.91 ms

# Comparison:
# Ryan        3.90 K
# Brad      0.0810 K - 48.19x slower +12.10 ms

# Memory usage statistics:

# Name    Memory usage
# Ryan        0.164 MB
# Brad         8.94 MB - 54.55x memory usage +8.77 MB
