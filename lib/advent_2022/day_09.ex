defmodule Advent2022.Day09 do
  @moduledoc """
  --- Day 9: Rope Bridge ---

  https://adventofcode.com/2022/day/9

  **Note:** I parse my input in the test setup because sharing input parsing
  every time is boring and nobody cares to see it (at least I don't).
  """

  @directions [:L, :R, :U, :D]
  @unit_vectors %{L: {-1, 0}, R: {1, 0}, U: {0, 1}, D: {0, -1}}

  @doc """
  Simulate your complete hypothetical series of motions. How many positions
  does the tail of the rope visit at least once?

  ## Examples

      iex> input = [
      ...>   {:R, 4},
      ...>   {:U, 4},
      ...>   {:L, 3},
      ...>   {:D, 1},
      ...>   {:R, 4},
      ...>   {:D, 1},
      ...>   {:L, 5},
      ...>   {:R, 2}
      ...> ]
      iex> part_1(input)
      13

      iex> input = [
      ...>   {:R, 1}, {:R, 1}, {:R, 1}, {:R, 1},
      ...>   {:U, 1}, {:U, 1}, {:U, 1}, {:U, 1},
      ...>   {:L, 1}, {:L, 1}, {:L, 1},
      ...>   {:D, 1},
      ...>   {:R, 1}, {:R, 1}, {:R, 1}, {:R, 1},
      ...>   {:D, 1},
      ...>   {:L, 1}, {:L, 1}, {:L, 1}, {:L, 1}, {:L, 1},
      ...>   {:R, 1}, {:R, 1}
      ...> ]
      iex> part_1(input)
      13

  """
  def part_1(input) do
    input
    |> travel({0, 0}, {0, 0}, MapSet.new([{0, 0}]))
    |> MapSet.size()
  end

  defp travel([], _h, _t, set), do: set

  # When the head and tail are touching, we will only move the head.
  defp travel([{dir, steps} | rest], {hx, hy} = h, {tx, ty} = t, set)
       when (hx - tx) in -1..1 and (hy - ty) in -1..1 do
    travel(rest, move(h, dir, steps), t, MapSet.put(set, t))
  end

  # When the head and tail are not touching, we will move the tail towards the head.
  defp travel(input, h, t, set) do
    travel(input, h, move_towards(t, h), MapSet.put(set, t))
  end

  defp move(from, dir_or_vec, steps \\ 1)
  defp move({x, y}, {vx, vy}, steps), do: {steps * vx + x, steps * vy + y}

  defp move(point, direction, steps) when direction in @directions do
    move(point, @unit_vectors[direction], steps)
  end

  defp move_towards({x1, y1}, {x2, y2}) do
    move({x1, y1}, {direction(x2, x1), direction(y2, y1)})
  end

  defp direction(c, c), do: 0
  defp direction(c2, c1) when c2 > c1, do: 1
  defp direction(c2, c1) when c2 < c1, do: -1
end
