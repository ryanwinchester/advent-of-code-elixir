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

      # iex> input = [
      # ...>   "28", "33", "18", "42", "31", "14", "46", "20", "48", "47", "24",
      # ...>   "23", "49", "45", "19", "38", "39", "11", "1", "32", "25", "35",
      # ...>   "8", "17", "7", "9", "4", "2", "34", "10", "3"
      # ...> ]
      # iex> Day10.part_2(input)
      # 19208

      # [1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19]


              1
            1(n^0) + 2(n^1) + 1(n^2) + 1(n^3) = 8

             2(x0^0) + 1(x1^1) + 1(x2^2) = 8; where x0 = 0, x1 = 1, x2 = 2

            [2, 1, 1]
            |> Enum.with_index()
            |> Enum.reduce(0, fn {value, index} -> value * :math.pow(index, index) end)

            n^n


      #                      (*1)         (*2)                    (*3)
      #     +1               +2           +1                       +1
      #     0       1        4            5       6      7        10       11       12     15    16    19    22
      #     |       |      / | \        /   \     |      |       /  \       |       |      |     |     |
      #     i1     i4    i5  i6  i7    i6    i7   i7     i10   i11   i12    i12    i15    i16    i19   i22

  """
  def part_2(input) do
    input
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
    |> get_nodes()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {value, index}, total ->
      value * :math.pow(index, index) + total
    end)
  end

  defp get_nodes(adapters) do
    length = Enum.count(adapters)

    adapters
    |> Enum.with_index()
    |> Enum.reduce([], fn {adapter, index}, new_branch_counts ->
      new_branch_count =
        adapters
        |> Enum.slice(index + 1, length)
        |> Enum.reduce_while(0, fn next_adapter, branch_count ->
          if next_adapter - adapter <= 3 do
            {:cont, branch_count + 1}
          else
            {:halt, branch_count}
          end
        end)

      [new_branch_count - 1 | new_branch_counts]
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
