defmodule Advent.Day3 do
  @moduledoc """
  Advent of Code - Day 3
  """

  @doc """

  ## Example

      iex> input = [
      ...>   "..##.......",
      ...>   "#...#...#..",
      ...>   ".#....#..#.",
      ...>   "..#.#...#.#",
      ...>   ".#...##..#.",
      ...>   "..#.##.....",
      ...>   ".#.#.#....#",
      ...>   ".#........#",
      ...>   "#.##...#...",
      ...>   "#...##....#",
      ...>   ".#..#...#.#"
      ...> ]
      iex> Advent.Day3.part_1(input)
      7

  """
  def part_1(geology) do
    count_trees(geology, {3, 1})
  end

  @doc """
  # Part 2 - Multiple slopes/positions.

  Moving slopes are now:

    Right 1, down 1.
    Right 3, down 1. (This is the slope you already checked.)
    Right 5, down 1.
    Right 7, down 1.
    Right 1, down 2.

  ## Example

      iex> input = [
      ...>   "..##.......",
      ...>   "#...#...#..",
      ...>   ".#....#..#.",
      ...>   "..#.#...#.#",
      ...>   ".#...##..#.",
      ...>   "..#.##.....",
      ...>   ".#.#.#....#",
      ...>   ".#........#",
      ...>   "#.##...#...",
      ...>   "#...##....#",
      ...>   ".#..#...#.#"
      ...> ]
      iex> Advent.Day3.part_2(input)
      336

  """
  def part_2(geology) do
    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(&count_trees(geology, &1))
    |> Enum.reduce(&(&1 * &2))
  end

  defp count_trees(geology, {x_inc, y_inc}) do
    geology
    |> Enum.take_every(y_inc)
    |> Enum.map(&row_stream/1)
    |> Enum.reduce({0, 0}, &check_for_tree(&1, &2, x_inc))
    |> elem(1)
  end

  defp check_for_tree(row, {pos, count}, inc_by) do
    case Enum.at(row, pos) do
      "#" -> {pos + inc_by, count + 1}
      "." -> {pos + inc_by, count}
    end
  end

  defp row_stream(row) do
    row
    |> String.split("", trim: true)
    |> Stream.cycle()
  end
end
