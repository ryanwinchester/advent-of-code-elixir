defmodule Advent2022.Day08Parser do
  @moduledoc """
  Parser for Day 08.

  ### Input

      30373
      25512
      65332
      33549
      35390

  ### Output

      %{
        {0, 0} => 3, {1, 0} => 0, {2, 0} => 3, {3, 0} => 7, {4, 0} => 3,
        {0, 1} => 2, {1, 1} => 5, {2, 1} => 5, {3, 1} => 1, {4, 1} => 2,
        {0, 2} => 6, {1, 2} => 5, {2, 2} => 3, {3, 2} => 3, {4, 2} => 2,
        {0, 3} => 3, {1, 3} => 3, {2, 3} => 5, {3, 3} => 4, {4, 3} => 9,
        {0, 4} => 3, {1, 4} => 5, {2, 4} => 3, {3, 4} => 9, {4, 4} => 0
      }

  """

  @n "\n"

  @doc """
  Turn a string grid into a list of {x, y, z} coordinates.
  """
  def input(input) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split("", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    for {row, y} <- Enum.with_index(grid), {z, x} <- Enum.with_index(row), into: %{} do
      {{x, y}, z}
    end
  end
end
