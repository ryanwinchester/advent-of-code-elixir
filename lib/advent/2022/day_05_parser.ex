defmodule Advent2022.Day05Parser do
  @moduledoc """
  Parser combinator for Day 05
  """
  import NimbleParsec

  box =
    ignore(string("["))
    |> ascii_string([?A..?Z], 1)
    |> ignore(string("]"))

  empty_space =
    ignore(string(" "))
    |> string(" ")
    |> ignore(string(" "))

  row =
    choice([box, empty_space])
    |> optional(ignore(string(" ")))
    |> times(min: 1)
    |> wrap()
    |> ignore(string("\n"))

  column_number =
    ignore(string(" "))
    |> integer(min: 1, max: 9)
    |> ignore(string(" "))

  bottom_row =
    column_number
    |> ignore(choice([string(" "), string("\n")]))
    |> times(max: 9)

  diagram =
    row
    |> times(min: 1)
    |> concat(ignore(bottom_row))
    |> tag(:rows)

  moves =
    ignore(string("move "))
    |> integer(min: 1, max: 9)
    |> ignore(string(" from "))
    |> integer(min: 1, max: 9)
    |> ignore(string(" to "))
    |> integer(min: 1, max: 9)
    |> ignore(string("\n"))
    |> wrap()
    |> map({List, :to_tuple, []})
    |> times(min: 1)
    |> tag(:moves)

  defparsec :input, diagram |> ignore(string("\n")) |> concat(moves), inline: true
end
