defmodule Advent2020.Day06Test do
  use Advent.FileCase, async: true

  alias Advent2020.Day06

  test "Part 1 - example" do
    input = """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """

    assert Day06.part_1(input) == 11
  end

  test "Part 1 - input file" do
    input = load_input(2020, "day-06")
    assert Day06.part_1(input) == 6170
  end

  test "Part 2 - example" do
    input = """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """

    assert Day06.part_2(input) == 6
  end

  test "Part 2 - input file" do
    input = load_input(2020, "day-06")
    assert Day06.part_2(input) == 2947
  end
end
