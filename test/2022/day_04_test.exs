defmodule Advent2022.Day04Test do
  use Advent.FileCase, async: true

  import Advent2022.Day04

  alias Advent2022.Day04Parser

  doctest Advent2022.Day04

  setup do
    parse_input(2022, "day-04", Day04Parser)
  end

  test "Part 1 - input file", %{input: input} do
    assert part_1(input) == 490
  end

  test "Part 2 - input file", %{input: input} do
    assert part_2(input) == 921
  end
end
