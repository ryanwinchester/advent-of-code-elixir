defmodule Advent.Day1Test do
  use ExUnit.Case, async: true

  alias Advent.Day1

  doctest Day1

  test "Part 1 - input file" do
    input =
      "../support/inputs/d01p1.txt"
      |> Path.expand(__DIR__)
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    assert Day1.part_1(input) == 1_015_476
  end

  test "Part 2 - input file" do
    input =
      "../support/inputs/d01p1.txt"
      |> Path.expand(__DIR__)
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    assert Day1.part_2(input) == 200_878_544
  end
end
