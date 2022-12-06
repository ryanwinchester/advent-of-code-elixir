defmodule Advent2022.Day06Test do
  use Advent.FileCase, async: true

  doctest Advent2022.Day06, import: true

  setup do
    {:ok, input: load_input({2022, 6})}
  end

  test "Part 1 - input file", %{input: input} do
    assert Advent2022.Day06.part_1(input) == 1640
  end

  test "Part 2 - input file", %{input: input} do
    assert Advent2022.Day06.part_2(input) == 3613
  end
end
