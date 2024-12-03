defmodule Advent2024.Day02Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2024

  alias Advent2024.Day02

  doctest Day02

  setup do
    input =
      Enum.map(load_input_lines({2024, 2}), fn line ->
        String.split(line) |> Enum.map(&String.to_integer/1)
      end)

    %{input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert Day02.part_1(input) == 257
  end

  # test "Part 2 - input file", %{input: input} do
  #   assert Day02.part_2(input) == 296
  # end
end
