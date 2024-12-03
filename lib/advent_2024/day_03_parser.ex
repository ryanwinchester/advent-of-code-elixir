defmodule Advent2024.Day03Parser do
  import NimbleParsec

  mult =
    ignore(string("mul("))
    |> integer(min: 1, max: 3)
    |> ignore(string(","))
    |> integer(min: 1, max: 3)
    |> ignore(string(")"))
    |> wrap()

  defparsec :part_1, choice([mult, ignore(ascii_string([1..255], 1))]) |> repeat()
end
