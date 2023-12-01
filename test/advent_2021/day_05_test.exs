defmodule Advent2021.Day05Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2021

  doctest Advent2021.Day05, import: true

  setup do
    input =
      load_input_lines({2021, 5})
      |> Enum.map(fn line ->
        line
        |> String.split(" -> ")
        |> Enum.map(fn point ->
          point
          |> String.split(",")
          |> Enum.map(&String.to_integer/1)
          |> List.to_tuple()
        end)
        |> List.to_tuple()
      end)

    {:ok, input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert Advent2021.Day05.part_1(input) == 8622
  end

  test "Part 2 - input file", %{input: input} do
    assert Advent2021.Day05.part_2(input) == 22037
  end
end
