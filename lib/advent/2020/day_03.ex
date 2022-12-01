defmodule Advent2020.Day03 do
  @moduledoc """
  --- Day 3: Toboggan Trajectory ---

  https://adventofcode.com/2020/day/3
  """

  @doc """
  # Part 1

  Count the trees on your slope path (`{3, 1}`).

  ## Example

      iex> tree_map = [
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
      iex> Day03.part_1(tree_map)
      7

  """
  def part_1(tree_map) do
    count_trees(tree_map, {3, 1})
  end

  @doc """
  # Part 2 - Multiple slope paths.

  Multiply together the number of trees encountered on each of the listed
  slopes.

  Moving slopes are now:

      Right 1, down 1.
      Right 3, down 1. (This is the slope you already checked.)
      Right 5, down 1.
      Right 7, down 1.
      Right 1, down 2.

  ## Example

      iex> tree_map = [
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
      iex> Day03.part_2(tree_map)
      336

  """
  def part_2(tree_map) do
    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(&count_trees(tree_map, &1))
    |> Enum.reduce(&(&1 * &2))
  end

  defp count_trees(tree_map, {x_increments, y_increments}) do
    tree_map
    |> Enum.take_every(y_increments)
    |> Enum.map(&row_stream/1)
    |> Enum.reduce({0, 0}, &check_for_tree(&1, &2, x_increments))
    |> elem(1)
  end

  defp check_for_tree(row, {pos, count}, increment_by) do
    case Enum.at(row, pos) do
      "#" -> {pos + increment_by, count + 1}
      "." -> {pos + increment_by, count}
    end
  end

  defp row_stream(row) do
    row
    |> String.split("", trim: true)
    |> Stream.cycle()
  end
end
