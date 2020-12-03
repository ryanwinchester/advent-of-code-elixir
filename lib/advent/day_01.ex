defmodule Advent.Day01 do
  @moduledoc """
  --- Day 1: Report Repair ---

  https://adventofcode.com/2020/day/1
  """

  @doc """
  Find the two entries that sum to 2020 and then multiply those two numbers
  together.

  ## Example

      iex> input = [1721, 979, 366, 299, 675, 1456]
      iex> Day01.part_1(input)
      514579

  """
  def part_1(entries) do
    entries
    |> get_part_1_results()
    |> List.first()
  end

  @doc """
  Find the three entries that sum to 2020 and find the product of the three.

  ## Example

      iex> input = [1721, 979, 366, 299, 675, 1456]
      iex> Day01.part_2(input)
      241861950

  """
  def part_2(entries) do
    entries
    |> get_part_2_results()
    |> List.first()
  end

  # Brute force method, don't judge me.
  defp get_part_1_results(items) do
    for x <- items,
        y <- items,
        x + y == 2020,
        do: x * y
  end

  defp get_part_2_results(items) do
    for x <- items,
        y <- items,
        z <- items,
        x + y + z == 2020,
        do: x * y * z
  end
end
