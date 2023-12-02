defmodule Advent2022.Day08Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2022

  alias Advent2022.Day08Parser

  doctest Advent2022.Day08, import: true

  setup do
    input = load_input({2022, 8}) |> Day08Parser.input()
    {:ok, input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert Advent2022.Day08.part_1(input) == 1719
  end

  test "Part 2 - input file", %{input: input} do
    assert Advent2022.Day08.part_2(input) == 590_824
  end
end
