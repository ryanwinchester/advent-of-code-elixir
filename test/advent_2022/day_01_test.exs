defmodule Advent2022.Day01Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2022

  doctest Advent2022.Day01, import: true

  setup do
    input = load_input_lines_chunked_to_integer({2022, 1})
    {:ok, input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert Advent2022.Day01.part_1(input) == 68923
  end

  test "Part 2 - input file", %{input: input} do
    assert Advent2022.Day01.part_2(input) == 200_044
  end
end
