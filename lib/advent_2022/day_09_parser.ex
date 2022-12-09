defmodule Advent2022.Day09Parser do
  @moduledoc """
  Parser for Day 09.

  ### Input

      R 4
      U 4
      L 3
      D 1
      R 4
      D 1
      L 5
      R 2

  ### Output

      [
        {:R, 4},
        {:U, 4},
        {:L, 3},
        {:D, 1},
        {:R, 4},
        {:D, 1},
        {:L, 5},
        {:R, 2}
      ]

  """

  def input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [dir, n] = String.split(line, " ", parts: 2)
      {String.to_atom(dir), String.to_integer(n)}
    end)
  end
end
