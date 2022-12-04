defmodule Advent2022.Day03Test do
  use Advent.FileCase, async: true

  doctest Advent2022.Day03, import: true

  setup do
    input = load_input_lines(~D[2022-12-03])
    {:ok, input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert Advent2022.Day03.part_1(input) == 8401
  end

  test "Part 2 - input file", %{input: input} do
    assert Advent2022.Day03.part_2(input) == 2641
  end
end
