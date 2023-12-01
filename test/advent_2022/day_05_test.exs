defmodule Advent2022.Day05Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2022

  doctest Advent2022.Day05, import: true

  setup do
    parse_input({2022, 5}, Advent2022.Day05Parser)
  end

  test "Part 1 - input file", %{input: [rows: rows, moves: moves]} do
    assert Advent2022.Day05.part_1(rows, moves) == "VWLCWGSDQ"
  end

  test "Part 2 - input file", %{input: [rows: rows, moves: moves]} do
    assert Advent2022.Day05.part_2(rows, moves) == "TCGLQSLPW"
  end
end
