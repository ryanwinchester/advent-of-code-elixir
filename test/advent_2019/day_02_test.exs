defmodule Advent2019.Day02Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2019

  alias Advent2019.Day02

  doctest Day02

  test "Part 1 - input file" do
    input =
      load_input({2019, 2})
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    assert Day02.part_1(input) == 54_82_655
  end

  test "Part 2 - input file" do
    input =
      load_input({2019, 2})
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    output = 19_690_720

    assert Day02.part_2(input, output) == 1202
  end
end
