defmodule Advent2021.Day02Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2021

  alias Advent2021.Day02

  doctest Day02

  setup do
    input = load_input_lines({2021, 2})
    {:ok, input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert Day02.part_1(input) == 1_383_564
  end

  test "Part 2 - input file", %{input: input} do
    assert Day02.part_2(input) == 1_488_311_643
  end
end
