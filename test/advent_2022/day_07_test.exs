defmodule Advent2022.Day07Test do
  use Advent.FileCase, async: true

  alias Advent2022.Day07Parser

  doctest Advent2022.Day07, import: true

  setup do
    input = load_input({2022, 7}) |> Day07Parser.input()
    {:ok, input: input}
  end

  test "Part 1 - input file", %{input: input} do
    assert Advent2022.Day07.part_1(input) == 1297683
  end

  test "Part 2 - input file", %{input: input} do
    assert Advent2022.Day07.part_2(input) == 5756764
  end
end
