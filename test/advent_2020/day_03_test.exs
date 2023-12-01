defmodule Advent2020.Day03Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2020

  alias Advent2020.Day03

  doctest Day03

  test "Part 1 - input file" do
    input = load_input_lines({2020, 3})
    assert Day03.part_1(input) == 148
  end

  test "Part 2 - input file" do
    input = load_input_lines({2020, 3})
    assert Day03.part_2(input) == 727_923_200
  end
end
