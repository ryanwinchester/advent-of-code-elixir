defmodule Advent2022.Day05Parser do
  @moduledoc """
  Parser combinators for Day 05.

  ### Input

          [D]
      [N] [C]
      [Z] [M] [P]
       1   2   3

      move 1 from 2 to 1
      move 3 from 1 to 3
      move 2 from 2 to 1
      move 1 from 1 to 2

  ### Output

      [
        rows: [
          [" ", "D", " "],
          ["N", "C", " "],
          ["Z", "M", "P"]
        ],
        moves: [
          {1, 2, 1},
          {3, 1, 3},
          {2, 2, 1},
          {1, 1, 2}
        ]
      ]

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

  defparsec(:input, diagram |> ignore(string("\n")) |> concat(moves), inline: true)
end
