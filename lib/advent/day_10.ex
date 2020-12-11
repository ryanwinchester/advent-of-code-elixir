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

            1 + 2(x0^0) + 1(x1^1) + 1(x2^2) = 8; where x0 = 0, x1 = 1, x2 = 2

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
    # |> Enum.with_index()
    |> adapter_arrangements(0, 0)
    # |> Enum.with_index()
    # |> reduce_stuff()
  end

  defp reduce_stuff([]), do: 0

  defp reduce_stuff(adapters) do
    length = Enum.count(adapters)

    Enum.reduce_while(adapters, :init, fn
      {current, index}, :init ->
        IO.inspect({current, index}, label: "INIT")
        {:cont, {current, index, 0}}

      {current, index}, {previous, _, count} ->
        IO.inspect({previous, current, count}, label: "Hi")
        IO.inspect({index, length}, label: "Index and Length")

        cond do
          index == length - 1 ->
            {:halt, count + 1}

          current - previous <= 3 ->
            branches_count =
              adapters
              |> Enum.slice(index, length)
              |> Enum.map(fn {value, _index} -> value end)
              |> Enum.with_index()
              |> reduce_stuff() #=> {19, 9, 0}

            {:cont, {current, index, count + branches_count}}

          true ->
            # not a branch
            {:halt, count}
        end
    end)
  end

  defp adapter_arrangements([], _, arrangements) do
    arrangements
  end

  defp adapter_arrangements([adapter | _rest], previous_adapter, arrangements) when adapter - previous_adapter > 3 do
    arrangements
  end

  defp adapter_arrangements([adapter | rest], _previous_adapter, arrangements) do
    IO.inspect(adapter, label: "CURRENT ADAPTER")

    branch_count =
      rest
      |> Enum.with_index()
      |> Enum.reduce_while(0, fn {next, index}, count ->
        IO.inspect({next, count}, label: "COUNTING")

        if next - adapter <= 3 do
          IO.inspect(next - adapter, label: "Starting branch count")

          branches_count =
            rest
            |> Enum.slice(index, Enum.count(rest))
            |> Enum.with_index()
            # |> adapter_arrangements()

          {:cont, count + branches_count}
        else
          # not a branch
          {:halt, count}
        end
      end)

    adapter_arrangements(rest, adapter, arrangements + branch_count)
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
