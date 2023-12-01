defmodule Advent2020.Day09Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2020

  alias Advent2020.Day09

  doctest Day09

  test "Part 1 - input file" do
    input = load_input_lines({2020, 9})
    assert Day09.part_1(input) == 14_360_655
  end

  test "Part 2 - input file" do
    input = load_input_lines({2020, 9})
    assert Day09.part_2(input) == 1_962_331
  end
end
