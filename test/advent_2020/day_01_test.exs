defmodule Advent2020.Day01Test do
  use Advent.FileCase, async: true

  alias Advent2020.Day01

  doctest Day01

  test "Part 1 - input file" do
    input = Enum.map(load_input_lines({2020, 1}), &String.to_integer/1)
    assert Day01.part_1(input) == 1_015_476
  end

  test "Part 2 - input file" do
    input = Enum.map(load_input_lines({2020, 1}), &String.to_integer/1)
    assert Day01.part_2(input) == 200_878_544
  end
end
