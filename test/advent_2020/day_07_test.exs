defmodule Advent2020.Day07Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2020

  alias Advent2020.Day07

  doctest Day07

  test "Part 1 - input file" do
    input = load_input_lines({2020, 7})
    assert Day07.part_1(input) == 335
  end

  test "Part 2 - input file" do
    input = load_input_lines({2020, 7})
    assert Day07.part_2(input) == 2431
  end
end
