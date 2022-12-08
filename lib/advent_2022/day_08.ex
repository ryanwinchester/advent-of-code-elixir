defmodule Advent2022.Day08 do
  @moduledoc """
  --- Day 8: Treetop Tree House ---

  https://adventofcode.com/2022/day/8

  **Note:** I parse my input in the test setup because sharing input parsing
  every time is boring and nobody cares to see it (at least I don't).
  """

  @doc """
  Consider your map; how many trees are visible from outside the grid?

  ## Examples

      iex> input = %{
      ...>   {0, 0} => 3, {1, 0} => 0, {2, 0} => 3, {3, 0} => 7, {4, 0} => 3,
      ...>   {0, 1} => 2, {1, 1} => 5, {2, 1} => 5, {3, 1} => 1, {4, 1} => 2,
      ...>   {0, 2} => 6, {1, 2} => 5, {2, 2} => 3, {3, 2} => 3, {4, 2} => 2,
      ...>   {0, 3} => 3, {1, 3} => 3, {2, 3} => 5, {3, 3} => 4, {4, 3} => 9,
      ...>   {0, 4} => 3, {1, 4} => 5, {2, 4} => 3, {3, 4} => 9, {4, 4} => 0
      ...> }
      iex> part_1(input)
      21

  """
  def part_1(grid) do
    x_length = Enum.filter(grid, fn {{x, _}, _} -> x == 0 end) |> Enum.count()
    y_length = Enum.filter(grid, fn {{_, y}, _} -> y == 0 end) |> Enum.count()

    visible_interior_trees =
      for {{x, y}, _} = tree <- grid,
          x not in [0, x_length - 1],
          y not in [0, y_length - 1],
            reduce: 0 do
        acc ->
          if visible_up(tree, grid, 0) or visible_down(tree, grid, y_length - 1) or
              visible_left(tree, grid, 0) or visible_right(tree, grid, x_length - 1) do
            acc + 1
          else
            acc
          end
      end

    2 * x_length + 2 * y_length - 4 + visible_interior_trees
  end

  defp visible_up({{x, y0}, z}, grid, edge) do
    Enum.reduce_while(y0-1..edge, true, fn y, _ ->
      if grid[{x, y}] < z, do: {:cont, true}, else: {:halt, false}
    end)
  end

  defp visible_down({{x, y0}, z}, grid, edge) do
    Enum.reduce_while(y0+1..edge, true, fn y, _ ->
      if grid[{x, y}] < z, do: {:cont, true}, else: {:halt, false}
    end)
  end

  defp visible_left({{x0, y}, z}, grid, edge) do
    Enum.reduce_while(x0-1..edge, true, fn x, _ ->
      if grid[{x, y}] < z, do: {:cont, true}, else: {:halt, false}
    end)
  end

  defp visible_right({{x0, y}, z}, grid, edge) do
    Enum.reduce_while(x0+1..edge, true, fn x, _ ->
      if grid[{x, y}] < z, do: {:cont, true}, else: {:halt, false}
    end)
  end

  @doc """
  Consider each tree on your map.
  What is the highest scenic score possible for any tree?

  ## Examples

      iex> input = %{
      ...>   {0, 0} => 3, {1, 0} => 0, {2, 0} => 3, {3, 0} => 7, {4, 0} => 3,
      ...>   {0, 1} => 2, {1, 1} => 5, {2, 1} => 5, {3, 1} => 1, {4, 1} => 2,
      ...>   {0, 2} => 6, {1, 2} => 5, {2, 2} => 3, {3, 2} => 3, {4, 2} => 2,
      ...>   {0, 3} => 3, {1, 3} => 3, {2, 3} => 5, {3, 3} => 4, {4, 3} => 9,
      ...>   {0, 4} => 3, {1, 4} => 5, {2, 4} => 3, {3, 4} => 9, {4, 4} => 0
      ...> }
      iex> part_2(input)
      8

  """
  def part_2(grid) do
    x_length = Enum.filter(grid, fn {{x, _}, _} -> x == 0 end) |> Enum.count()
    y_length = Enum.filter(grid, fn {{_, y}, _} -> y == 0 end) |> Enum.count()

    Enum.reduce(grid, %{}, fn {{x, y}, _} = tree, acc ->
      scenic_score =
        distance_up(tree, grid, 0)
         * distance_down(tree, grid, y_length - 1)
         * distance_left(tree, grid, 0)
         * distance_right(tree, grid, x_length - 1)

      Map.put(acc, {x, y}, scenic_score)
    end)
    |> Map.values()
    |> Enum.max()
  end

  defp distance_up({{_, 0}, _}, _, _), do: 0

  defp distance_up({{x, y0}, z}, grid, edge) do
    Enum.reduce_while(y0-1..edge, 0, fn y, d ->
      cond do
        grid[{x, y}] == 0 -> {:cont, d}
        y == edge -> {:halt, d + 1}
        grid[{x, y}] < z -> {:cont, d + 1}
        true -> {:halt, d + 1}
      end
    end)
  end

  defp distance_down({{_, edge}, _}, edge, _), do: 0

  defp distance_down({{x, y0}, z}, grid, edge) do
    Enum.reduce_while(y0+1..edge, 0, fn y, d ->
      cond do
        grid[{x, y}] == 0 -> {:cont, d}
        y == edge -> {:halt, d + 1}
        grid[{x, y}] < z -> {:cont, d + 1}
        true -> {:halt, d + 1}
      end
    end)
  end

  defp distance_left({{0, _}, _}, _, _), do: 0

  defp distance_left({{x0, y}, z}, grid, edge) do
    Enum.reduce_while(x0-1..edge, 0, fn x, d ->
      cond do
        grid[{x, y}] == 0 -> {:cont, d}
        x == edge -> {:halt, d + 1}
        grid[{x, y}] < z -> {:cont, d + 1}
        true -> {:halt, d + 1}
      end
    end)
  end

  defp distance_right({{edge, _}, _}, edge, _), do: 0

  defp distance_right({{x0, y}, z}, grid, edge) do
    Enum.reduce_while(x0+1..edge, 0, fn x, d ->
      cond do
        grid[{x, y}] == 0 -> {:cont, d}
        x == edge -> {:halt, d + 1}
        grid[{x, y}] < z -> {:cont, d + 1}
        true -> {:halt, d + 1}
      end
    end)
  end
end
