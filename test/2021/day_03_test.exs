defmodule Advent2021.Day03Test do
  use Advent.FileCase, async: true

  alias Advent2021.Day03

  doctest Day03

  setup do
    input = load_input_lines(~D[2021-12-03])
    {:ok, input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert Day03.part_1(input) == 2_583_164
  end

  test "Part 2 - input file", %{input: input} do
    assert Day03.part_2(input) == 2_784_375
  end
end
