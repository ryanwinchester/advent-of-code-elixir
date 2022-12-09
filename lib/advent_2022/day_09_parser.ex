defmodule Advent2022.Day09Parser do
  @moduledoc """
  Parser for Day 09.
  """

  @doc """

  ## Example

      iex> input = \"""
      ...>   R 4
      ...>   U 4
      ...>   L 3
      ...>   D 1
      ...>   R 4
      ...>   D 1
      ...>   L 5
      ...>   R 2
      ...>   \"""
      iex> input(input)
      [
        {:R, 1}, {:R, 1}, {:R, 1}, {:R, 1},
        {:U, 1}, {:U, 1}, {:U, 1}, {:U, 1},
        {:L, 1}, {:L, 1}, {:L, 1},
        {:D, 1},
        {:R, 1}, {:R, 1}, {:R, 1}, {:R, 1},
        {:D, 1},
        {:L, 1}, {:L, 1}, {:L, 1}, {:L, 1}, {:L, 1},
        {:R, 1}, {:R, 1}
      ]

  """
  def input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.flat_map(fn line ->
      [dir, n] = String.split(line, " ", parts: 2)
      dir = String.to_atom(dir)
      n = String.to_integer(n)
      for _ <- 1..n, do: {dir, 1}
    end)
    |> IO.inspect()
  end
end
