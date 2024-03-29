defmodule Advent2021.Day01 do
  @moduledoc """
  --- Day 1: Sonar Sweep ---

  https://adventofcode.com/2021/day/1
  """

  @doc """
  count the number of times a depth measurement increases from the previous
  measurement.

  ## Example

      iex> report = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
      iex> Day01.part_1(report)
      7

  """
  def part_1(report), do: count_increases(report, 0)

  @doc """
  Consider sums of a three-measurement sliding window. How many sums are larger
  than the previous sum?

  ## Example

      iex> report = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
      iex> Day01.part_2(report)
      5

  """
  def part_2(report) do
    report
    |> sum_windows([])
    |> count_increases(0)
  end

  ## Helpers

  # Count the number of times an item in a list is greater than the item before
  # it. The first item has no increase.
  defp count_increases([a, b | []], total), do: inc_total(a, b, total)

  defp count_increases([a, b | rest], total),
    do: count_increases([b | rest], inc_total(a, b, total))

  # Increment the total when b > a.
  defp inc_total(a, b, total) when b - a > 0, do: total + 1
  defp inc_total(_, _, total), do: total

  # Sum three-item windows from a list. Stop when there is not a full window of
  # three.
  defp sum_windows([_, _], acc), do: Enum.reverse(acc)

  defp sum_windows([a, b, c | rest], acc),
    do: sum_windows([b, c | rest], [a + b + c | acc])
end
