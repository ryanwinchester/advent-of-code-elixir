defmodule Advent2022.Day05Test do
  use Advent.FileCase, async: true

  doctest Advent2022.Day05, import: true

  setup do
    parse_input(~D[2022-12-05], Advent2022.Day05Parser)
  end

  test "Part 1 - input file", %{input: [rows: rows, moves: moves]} do
    assert Advent2022.Day05.part_1(rows, moves) == "VWLCWGSDQ"
  end

  test "Part 2 - input file", %{input: [rows: rows, moves: moves]} do
    assert Advent2022.Day05.part_2(rows, moves) == "TCGLQSLPW"
  end
end
