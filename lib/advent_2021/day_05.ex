defmodule Advent2021.Day05 do
  @moduledoc """
  --- Day 5: Hydrothermal Venture ---

  https://adventofcode.com/2021/day/5

  ## Example input

      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2

  """

  @doc """
  Consider only horizontal and vertical lines. At how many points do at least
  two lines overlap?

  ## Example

      iex> lines = [
      ...>   {{0, 9}, {5, 9}},
      ...>   {{8, 0}, {0, 8}},
      ...>   {{9, 4}, {3, 4}},
      ...>   {{2, 2}, {2, 1}},
      ...>   {{7, 0}, {7, 4}},
      ...>   {{6, 4}, {2, 0}},
      ...>   {{0, 9}, {2, 9}},
      ...>   {{3, 4}, {1, 4}},
      ...>   {{0, 0}, {8, 8}},
      ...>   {{5, 5}, {8, 2}}
      ...> ]
      iex> part_1(lines)
      5

  """
  def part_1(lines), do: count_overlaps(lines, 1)

  @doc """
  Consider only horizontal and vertical lines. At how many points do at least
  two lines overlap?

  ## Example

      iex> lines = [
      ...>   {{0, 9}, {5, 9}},
      ...>   {{8, 0}, {0, 8}},
      ...>   {{9, 4}, {3, 4}},
      ...>   {{2, 2}, {2, 1}},
      ...>   {{7, 0}, {7, 4}},
      ...>   {{6, 4}, {2, 0}},
      ...>   {{0, 9}, {2, 9}},
      ...>   {{3, 4}, {1, 4}},
      ...>   {{0, 0}, {8, 8}},
      ...>   {{5, 5}, {8, 2}}
      ...> ]
      iex> part_2(lines)
      12

  """
  def part_2(lines), do: count_overlaps(lines, 2)

  defp count_overlaps(lines, part) do
    lines
    |> Enum.reduce(%{}, &update_point_counts(&1, &2, part))
    |> Map.values()
    |> Enum.filter(&(&1 > 1))
    |> Enum.count()
  end

  # Horizontal lines.
  defp update_point_counts({{x1, y}, {x2, y}}, point_counts, _) do
    for x <- x1..x2, reduce: point_counts do
      acc -> Map.update(acc, {x, y}, 1, &(&1 + 1))
    end
  end

  # Vertical lines.
  defp update_point_counts({{x, y1}, {x, y2}}, point_counts, _) do
    for y <- y1..y2, reduce: point_counts do
      acc -> Map.update(acc, {x, y}, 1, &(&1 + 1))
    end
  end

  # Diagonal lines.
  defp update_point_counts({{x1, y1}, {x2, y2}}, point_counts, 2) do
    x = for x <- x1..x2, do: x
    y = for y <- y1..y2, do: y

    [x, y]
    |> List.zip()
    |> Enum.reduce(point_counts, fn point, acc ->
      Map.update(acc, point, 1, &(&1 + 1))
    end)
  end

  # Ignore diagonal lines in part 1.
  defp update_point_counts(_line, point_counts, 1), do: point_counts
end
