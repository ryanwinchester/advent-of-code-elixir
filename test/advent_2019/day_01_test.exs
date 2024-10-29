defmodule Advent2019.Day01Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2019

  alias Advent2019.Day01

  doctest Day01

  test "Part 1 - input file" do
    input = Enum.map(load_input_lines({2019, 1}), &String.to_integer/1)
    assert Day01.part_1(input) == 3_297_626
  end

  test "Part 2 - input file" do
    input = Enum.map(load_input_lines({2019, 1}), &String.to_integer/1)
    assert Day01.part_2(input) == 4_943_578
  end
end
