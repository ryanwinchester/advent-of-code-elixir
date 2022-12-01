defmodule Advent2022.Day01Test do
  use Advent.FileCase

  alias Advent2022.Day01

  doctest Day01

  setup do
    input = load_file_lines_chunked_to_integer(2022, "day-01")
    {:ok, input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert Day01.part_1(input) == 68923
  end

  test "Part 2 - input file", %{input: input} do
    assert Day01.part_2(input) == 200_044
  end
end
