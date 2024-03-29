defmodule Advent2022.Day02Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2022

  doctest Advent2022.Day02, import: true

  setup do
    input = load_input_lines({2022, 2}) |> Enum.map(&String.split(&1, " ", trim: true))
    {:ok, input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert Advent2022.Day02.part_1(input) == 9177
  end

  test "Part 2 - input file", %{input: input} do
    assert Advent2022.Day02.part_2(input) == 12111
  end
end
