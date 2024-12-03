defmodule Advent2024.Day03Parser do
  import NimbleParsec

  mul_instruction =
    ignore(string("mul("))
    |> integer(min: 1, max: 3)
    |> ignore(string(","))
    |> integer(min: 1, max: 3)
    |> ignore(string(")"))
    |> wrap()

  part_1 =
    choice([
      mul_instruction,
      ignore(ascii_string([1..255], 1))
    ])
    |> repeat()

  # TODO/WIP
  part_2 =
    empty()
    |> optional(mul_instruction)

  defparsec :part_1, part_1

  defparsec :part_2, part_2
end
