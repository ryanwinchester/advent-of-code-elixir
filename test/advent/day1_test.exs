defmodule Advent.Day1Test do
  use ExUnit.Case, async: true

  alias Advent.Day1

  test "Part 1 - Example test case" do
    input = [1721, 979, 366, 299, 675, 1456]
    result = Day1.part_1(input)

    assert result == 514579
  end

  test "Part 1 - input file" do
    result =
      "../support/inputs/d1p1.txt"
      |> Path.expand(__DIR__)
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Day1.part_1()

    assert result == 1015476
  end
end
