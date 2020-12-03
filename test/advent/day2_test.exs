defmodule Advent.Day2Test do
  use Advent.FileCase

  alias Advent.Day2

  doctest Day2

  test "Part 1 - input file" do
    input = load_file("d02p1")
    assert Day2.part_1(input) == 524
  end

  test "Part 2 - input file" do
    input = load_file("d02p1")
    assert Day2.part_2(input) == 485
  end
end
