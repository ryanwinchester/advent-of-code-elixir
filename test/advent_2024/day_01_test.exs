defmodule Advent2024.Day01Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2024

  alias Advent2024.Day01

  doctest Day01

  setup do
    {list_1, list_2} =
      load_input_lines({2024, 1})
      |> Enum.map(fn line ->
        String.split(line)
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
      |> Enum.unzip()

    %{input: {list_1, list_2}}
  end

  test "Part 1 - input file", %{input: {list_1, list_2}} do
    assert Day01.part_1(list_1, list_2) == 2_742_123
  end

  test "Part 2 - input file", %{input: {list_1, list_2}} do
    assert Day01.part_2(list_1, list_2) == 21_328_497
  end
end
