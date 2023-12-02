defmodule Advent2022.Day04Parser do
  @moduledoc """
  Parser combinators for Day 04.

  ### Input

      2-4,6-8
      2-3,4-5
      5-7,7-9
      2-8,3-7
      6-6,4-6
      2-6,4-8

  ### Output

    [
      {2..4, 6..8},
      {2..3, 4..5},
      {5..7, 7..9},
      {2..8, 3..7},
      {6..6, 4..6},
      {2..6, 4..8}
    ]

  """
  import NimbleParsec

  range =
    integer(min: 1, max: 99)
    |> ignore(string("-"))
    |> integer(min: 1, max: 99)

  pair =
    range
    |> ignore(string(","))
    |> concat(range)
    |> ignore(string("\n"))
    |> reduce(:to_range_pair)

  defparsec(:input, pair |> repeat() |> eos(), inline: true)

  defp to_range_pair([a, b, c, d]), do: {Range.new(a, b), Range.new(c, d)}
end
