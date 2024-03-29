defmodule Advent2020.Day05Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2020

  alias Advent2020.Day05

  doctest Day05

  test "Part 1 - input file" do
    input = load_input_lines({2020, 5})
    assert Day05.part_1(input) == 928
  end

  test "Part 2 - input file" do
    input = load_input_lines({2020, 5})
    assert Day05.part_2(input) == 610
  end
end
