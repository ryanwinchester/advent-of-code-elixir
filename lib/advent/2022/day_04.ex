defmodule Advent2022.Day04 do
  @moduledoc """
  --- Day 4: Camp Cleanup ---

  https://adventofcode.com/2022/day/4
  """

  @doc """
  In how many assignment pairs does one range fully contain the other?

  ## Example

      iex> sections = [
      ...>   {2..4, 6..8},
      ...>   {2..3, 4..5},
      ...>   {5..7, 7..9},
      ...>   {2..8, 3..7},
      ...>   {6..6, 4..6},
      ...>   {2..6, 4..8}
      ...> ]
      iex> part_1(sections)
      2

  """
  def part_1(sections) do
    Enum.reduce(sections, 0, fn {a, b}, count ->
      cond do
        a.first >= b.first and a.last <= b.last -> count + 1
        b.first >= a.first and b.last <= a.last -> count + 1
        true -> count
      end
    end)
  end

  @doc """
  In how many assignment pairs do the ranges overlap?

  ## Example

      iex> sections = [
      ...>   {2..4, 6..8},
      ...>   {2..3, 4..5},
      ...>   {5..7, 7..9},
      ...>   {2..8, 3..7},
      ...>   {6..6, 4..6},
      ...>   {2..6, 4..8}
      ...> ]
      iex> part_2(sections)
      4

  """
  def part_2(sections) do
    Enum.reduce(sections, 0, fn {a, b}, count ->
      if Range.disjoint?(a, b), do: count, else: count + 1
    end)
  end
end
