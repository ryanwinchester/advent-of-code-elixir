defmodule Advent2022.Day04Test do
  use Advent.FileCase, async: true

  doctest Advent2022.Day04, import: true

  setup do
    parse_input(~D[2022-12-04], Advent2022.Day04Parser)
  end

  test "Part 1 - input file", %{input: input} do
    assert Advent2022.Day04.part_1(input) == 490
  end

  test "Part 2 - input file", %{input: input} do
    assert Advent2022.Day04.part_2(input) == 921
  end
end
