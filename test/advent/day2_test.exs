defmodule Advent.Day2Test do
  use ExUnit.Case, async: true

  alias Advent.Day2

  doctest Day2

  test "Part 1 - input file" do
    input =
      "../support/inputs/d02p1.txt"
      |> Path.expand(__DIR__)
      |> File.read!()
      |> String.split("\n", trim: true)

    assert Day2.part_1(input) == 524
  end

  test "Part 2 - input file" do
    input =
      "../support/inputs/d02p1.txt"
      |> Path.expand(__DIR__)
      |> File.read!()
      |> String.split("\n", trim: true)

    assert Day2.part_2(input) == 485
  end
end
