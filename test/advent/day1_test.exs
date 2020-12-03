defmodule Advent.Day1Test do
  use Advent.FileCase

  alias Advent.Day1

  doctest Day1

  test "Part 1 - input file" do
    input = Enum.map(load_file("d01p1"), &String.to_integer/1)
    assert Day1.part_1(input) == 1_015_476
  end

  test "Part 2 - input file" do
    input = Enum.map(load_file("d01p1"), &String.to_integer/1)
    assert Day1.part_2(input) == 200_878_544
  end
end
