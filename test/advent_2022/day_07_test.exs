defmodule Advent2022.Day07Test do
  use Advent.FileCase, async: true

  doctest Advent2022.Day07, import: true

  setup do
    {:ok, input: load_input({2022, 7})}
  end

  test "Part 1 - input file", %{input: input} do
    assert Advent2022.Day07.part_1(input) == 1297683
  end

  # test "Part 2 - input file", %{input: input} do
  #   assert Advent2022.Day07.part_2(input) == 0
  # end
end
