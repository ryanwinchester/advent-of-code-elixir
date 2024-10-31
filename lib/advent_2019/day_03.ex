defmodule Advent2019.Day03 do
  @moduledoc """
  --- Day 3: Crossed Wires ---

  https://adventofcode.com/2019/day/3
  """

  @doc """
  What is the Manhattan distance from the central port to the closest
  intersection?

  ## Examples

      iex> path_1 = ~w[R8 U5 L5 D3]
      iex> path_2 = ~w[U7 R6 D4 L4]
      iex> Day03.part_1(path_1, path_2)
      6

      iex> path_1 = ~w[R75 D30 R83 U83 L12 D49 R71 U7 L72]
      iex> path_2 = ~w[U62 R66 U55 R34 D71 R55 D58 R83]
      iex> Day03.part_1(path_1, path_2)
      159

      iex> path_1 = ~w[R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51]
      iex> path_2 = ~w[U98 R91 D20 R16 D67 R40 U7 R15 U6 R7]
      iex> Day03.part_1(path_1, path_2)
      135

  """
  def part_1(path_1, path_2) do
    {path_to_points(path_1), path_to_points(path_2)}
    |> intersections()
    |> Enum.map(&manhattan_distance/1)
    |> Enum.min()
  end

  # Convert a path to a list of points in the path.
  defp path_to_points(path) do
    Enum.reduce(path, [{0, 0}], fn move, points ->
      <<direction::binary-1, places::binary>> = move
      [last_point | _] = points
      places = String.to_integer(places)
      next_points(direction, places, last_point) ++ points
    end)
    |> Enum.reverse()
  end

  # Fill out all the {x, y} points for a path movement.
  defp next_points(direction, places, last_point)
  defp next_points("U", places, {x, y}), do: Enum.reduce(1..places, [], &[{x, y + &1} | &2])
  defp next_points("D", places, {x, y}), do: Enum.reduce(1..places, [], &[{x, y - &1} | &2])
  defp next_points("R", places, {x, y}), do: Enum.reduce(1..places, [], &[{x + &1, y} | &2])
  defp next_points("L", places, {x, y}), do: Enum.reduce(1..places, [], &[{x - &1, y} | &2])

  defp intersections({points_1, points_2}) do
    MapSet.intersection(MapSet.new(points_1), MapSet.new(points_2)) |> MapSet.delete({0, 0})
  end

  defp manhattan_distance({x2, y2}, {x1, y1} \\ {0, 0}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  @doc """
  What is the fewest combined steps the wires must take to reach an intersection?

  ## Examples

      iex> path_1 = ~w[R8 U5 L5 D3]
      iex> path_2 = ~w[U7 R6 D4 L4]
      iex> Day03.part_2(path_1, path_2)
      30

      iex> path_1 = ~w[R75 D30 R83 U83 L12 D49 R71 U7 L72]
      iex> path_2 = ~w[U62 R66 U55 R34 D71 R55 D58 R83]
      iex> Day03.part_2(path_1, path_2)
      610

      iex> path_1 = ~w[R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51]
      iex> path_2 = ~w[U98 R91 D20 R16 D67 R40 U7 R15 U6 R7]
      iex> Day03.part_2(path_1, path_2)
      410

  """
  def part_2(path_1, path_2) do
    points_1 = path_to_points(path_1)
    points_2 = path_to_points(path_2)

    intersections({points_1, points_2})
    |> Enum.map(&(steps_to_point(points_1, &1) + steps_to_point(points_2, &1)))
    |> Enum.min()
  end

  # Find the number of steps to get to a point in the path.
  # This is really just the index since we built the path as a list of points.
  defp steps_to_point(points, to_point) do
    Enum.find_index(points, &(&1 == to_point))
  end
end
