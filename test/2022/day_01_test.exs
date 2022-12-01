defmodule Advent2022.Day01Test do
  use Advent.FileCase

  alias Advent2022.Day01

  doctest Day01

  setup do
    groups = load_file_groups(2022, "day-01")

    input =
      for g <- groups do
        for n <- g do
          String.to_integer(n)
        end
      end

    {:ok, input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert Day01.part_1(input) == 68923
  end

  test "Part 2 - input file", %{input: input} do
    assert Day01.part_2(input) == 1611
  end
end
