defmodule Advent2021.Day02 do
  @moduledoc """
  --- Day 2: Dive! ---

  https://adventofcode.com/2021/day/2
  """

  @doc """
  Calculate the horizontal position and depth you would have after following the
  planned course, and return their product.

  ## Example

      iex> course = [
      ...>   "forward 5",
      ...>   "down 5",
      ...>   "forward 8",
      ...>   "up 3",
      ...>   "down 8",
      ...>   "forward 2"
      ...> ]
      iex> Day02.part_1(course)
      150

  """
  def part_1(course) do
    {x, y} = travel(course, {0, 0})
    x * y
  end

  @doc """
  Calculate the horizontal position and depth you would have after following the
  planned course, and return their product.

  ## Example

      iex> commands = [
      ...>   "forward 5",
      ...>   "down 5",
      ...>   "forward 8",
      ...>   "up 3",
      ...>   "down 8",
      ...>   "forward 2"
      ...> ]
      iex> Day02.part_2(commands)
      900

  """
  def part_2(commands) do
    {x, y, _z} = travel(commands, {0, 0, 0})
    x * y
  end

  ## Helpers

  defp travel([], position), do: position

  defp travel([cmd | commands], position),
    do: travel(commands, move(cmd, position))

  # Move with 2 coordinates.
  defp move("forward " <> d, {x, y}), do: {x + String.to_integer(d), y}
  defp move("down " <> d, {x, y}), do: {x, y + String.to_integer(d)}
  defp move("up " <> d, {x, y}), do: {x, y - String.to_integer(d)}

  # Move with third coordinate, `aim`.
  defp move("down " <> d, {x, y, z}), do: {x, y, z + String.to_integer(d)}
  defp move("up " <> d, {x, y, z}), do: {x, y, z - String.to_integer(d)}

  defp move("forward " <> d, {x, y, z}) do
    d = String.to_integer(d)
    {x + d, y + z * d, z}
  end
end
