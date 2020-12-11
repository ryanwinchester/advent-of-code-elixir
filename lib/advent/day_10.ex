defmodule Advent.Day10 do
  @moduledoc """
  --- Day 10: Adapter Array ---
  https://adventofcode.com/2020/day/10
  """

  @doc """
  Get the number of 1-jolt differences multiplied by the number of 3-jolt
  differences.

  ## Example

      iex> input = ["16", "10", "15", "5", "1", "11", "7", "19", "6", "12", "4"]
      iex> Day10.part_1(input)
      35

      iex> input = [
      ...>   "28", "33", "18", "42", "31", "14", "46", "20", "48", "47", "24",
      ...>   "23", "49", "45", "19", "38", "39", "11", "1", "32", "25", "35",
      ...>   "8", "17", "7", "9", "4", "2", "34", "10", "3"
      ...> ]
      iex> Day10.part_1(input)
      220

  """
  def part_1(input) do
    input
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
    |> joltage_differences()
  end

  @doc """
  Get the total number of distinct ways you can arrange the adapters to connect
  the charging outlet to your device.

  ## Example

      iex> input = ["16", "10", "15", "5", "1", "11", "7", "19", "6", "12", "4"]
      iex> Day10.part_2(input)
      8

      iex> input = [
      ...>   "28", "33", "18", "42", "31", "14", "46", "20", "48", "47", "24",
      ...>   "23", "49", "45", "19", "38", "39", "11", "1", "32", "25", "35",
      ...>   "8", "17", "7", "9", "4", "2", "34", "10", "3"
      ...> ]
      iex> Day10.part_2(input)
      19208

  """
  def part_2(input) do
    adapters =
      input
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()

    adapters = [0 | adapters] ++ [Enum.at(adapters, -1) + 3]

    length = Enum.count(adapters)

    paths = get_path_counts(adapters)

    rabbit_hole(0, adapters, length, paths, %{})
  end

  defp rabbit_hole(index, adapters, length, paths, cache) do
    case paths[index] do
      [] ->
        1

      indexes ->
        {total, _cache} =
          Enum.reduce(indexes, {0, cache}, fn i, {total, cache} ->
            case cache[i] do
              nil ->
                value = rabbit_hole(i, adapters, length, paths, cache)
                {value + total, Map.put(cache, i, value)}

              value ->
                {value + total, cache}
            end
          end)

        total
    end
  end

  defp get_path_counts(adapters) do
    length = Enum.count(adapters)

    adapters
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {adapter, index}, acc ->
      new_branch_indexes =
        adapters
        |> Enum.with_index()
        |> Enum.slice(index + 1, length)
        |> Enum.reduce_while([], fn {next_adapter, i}, indexes ->
          if next_adapter - adapter <= 3 do
            {:cont, [i | indexes]}
          else
            {:halt, indexes}
          end
        end)

      Map.put(acc, index, new_branch_indexes)
    end)
  end

  defp joltage_differences(adapter_joltages) do
    state = %{previous_joltage: 0, diffs_1: 0, diffs_3: 1}
    joltage_differences(adapter_joltages, state)
  end

  defp joltage_differences([], %{diffs_1: diffs_1, diffs_3: diffs_3}), do: diffs_1 * diffs_3

  defp joltage_differences([joltage | rest], state) do
    case joltage - state.previous_joltage do
      1 ->
        joltage_differences(rest, %{state | previous_joltage: joltage, diffs_1: state.diffs_1 + 1})

      3 ->
        joltage_differences(rest, %{state | previous_joltage: joltage, diffs_3: state.diffs_3 + 1})
    end
  end
end
