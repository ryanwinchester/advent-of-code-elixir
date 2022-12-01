defmodule Advent2022.Day01 do
  @moduledoc """
  --- Day 1: Calorie Counting ---

  https://adventofcode.com/2022/day/1
  """

  @doc """
  Find the Elf carrying the most Calories.
  How many total Calories is that Elf carrying?

  ## Example

      iex> calories = [
      ...>   [1000, 2000, 3000], [4000], [5000, 6000],
      ...>   [7000, 8000, 9000], [10000]
      ...> ]
      iex> Day01.part_1(calories)
      24_000

  """
  def part_1(calories) do
    calories
    |> Enum.map(&Enum.sum/1)
    |> Enum.max()
  end

  @doc """
  Find the top three Elves carrying the most Calories.

  How many Calories are those Elves carrying in total?

  ## Example

      iex> calories = [
      ...>   [1000, 2000, 3000], [4000], [5000, 6000],
      ...>   [7000, 8000, 9000], [10000]
      ...> ]
      iex> Day01.part_2(calories)
      45_000

  """
  def part_2(calories) do
    calories
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end
end
