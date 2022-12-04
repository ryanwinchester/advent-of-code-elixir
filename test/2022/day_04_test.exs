defmodule Advent2022.Day04Test do
  use Advent.FileCase, async: true

  import Advent2022.Day04

  doctest Advent2022.Day04

  setup do
    input =
      load_input_lines(2022, "day-04")
      |> Enum.map(fn pair ->
        pair
        |> String.split(",", trim: true)
        |> Enum.map(fn range_str ->
          [a, b] = String.split(range_str, "-")
          Range.new(String.to_integer(a), String.to_integer(b))
        end)
        |> List.to_tuple()
      end)

    {:ok, input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert part_1(input) == 490
  end

  test "Part 2 - input file", %{input: input} do
    assert part_2(input) == 921
  end
end
