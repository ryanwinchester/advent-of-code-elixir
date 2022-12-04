defmodule Advent2022.Day04Parser do
  @moduledoc """
  Parser combinator for Day 04
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

  defparsec :input, pair |> repeat() |> eos(), inline: true

  defp to_range_pair([a, b, c, d]), do: {Range.new(a, b), Range.new(c, d)}
end
