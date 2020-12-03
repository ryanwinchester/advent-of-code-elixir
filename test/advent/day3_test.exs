defmodule Advent.Day3Test do
  use Advent.FileCase

  alias Advent.Day3

  doctest Day3

  test "Part 1 - input file" do
    input = load_file("d03p1")
    assert Day3.part_1(input) == 148
  end

  test "Part 2 - input file" do
    input = load_file("d03p1")
    assert Day3.part_2(input) == 727923200
  end
end
