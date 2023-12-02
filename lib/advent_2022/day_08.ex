defmodule Advent2022.Day08 do
  @moduledoc """
  --- Day 8: Treetop Tree House ---

  https://adventofcode.com/2022/day/8

  **Note:** I parse my input in the test setup because sharing input parsing
  every time is boring and nobody cares to see it (at least I don't).
  """

  @unit_vectors [{0, -1}, {0, 1}, {1, 0}, {-1, 0}]

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
    x_max = x_length - 1
    y_max = y_length - 1

    visible_interior_trees =
      Enum.reduce(grid, 0, fn
        # Ignore trees on the edges.
        {{x, _}, _}, count when x in [0, x_max] ->
          count

        {{_, y}, _}, count when y in [0, y_max] ->
          count

        # Count the interior trees.
        tree, count ->
          visible =
            Enum.reduce(
              @unit_vectors,
              false,
              &(&2 or visible_direction(tree, elem(tree, 0), &1, grid))
            )

          if visible, do: count + 1, else: count
      end)

    2 * x_length + 2 * y_length - 4 + visible_interior_trees
  end

  defp visible_direction({_, tree_height} = original, point, unit_vector, grid) do
    case grid[add(point, unit_vector)] do
      # We've reached the edge. We're visible!
      nil ->
        true

      # We've reached a blocking tree. Not visible
      height when height >= tree_height ->
        false

      _ ->
        # We can keep going. Increment the score and continue in this direction.
        visible_direction(original, add(point, unit_vector), unit_vector, grid)
    end
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
    Enum.reduce(grid, %{}, fn tree, scores ->
      score =
        Enum.reduce(
          @unit_vectors,
          1,
          &(&2 * scenic_direction_score(tree, elem(tree, 0), &1, grid))
        )

      Map.put(scores, tree, score)
    end)
    |> Map.values()
    |> Enum.max()
  end

  defp scenic_direction_score({_, tree_height} = original, point, unit_vector, grid, score \\ 0) do
    case grid[add(point, unit_vector)] do
      nil ->
        # We've reached the edge. Return the score.
        score

      height when height >= tree_height ->
        # We've reached a blocking tree. Return the score plus this tree.
        score + 1

      _ ->
        # We can keep going. Increment the score and continue in this direction.
        scenic_direction_score(original, add(point, unit_vector), unit_vector, grid, score + 1)
    end
  end

  defp add({x, y}, {vx, vy}), do: {x + vx, y + vy}
end
