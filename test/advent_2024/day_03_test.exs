defmodule Advent2024.Day03Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2024

  alias Advent2024.Day03
  alias Advent2024.Day03Parser

  doctest Day03

  setup do
    %{input: load_input({2024, 3})}
  end

  test "Part 1 - input file", %{input: input} do
    assert Day03.part_1(input) == 184_122_457
  end

  test "Part 1 - input file with parser" do
    {:ok, input, "", %{}, _, _} = load_input({2024, 3}) |> Day03Parser.part_1()

    result =
      Enum.reduce(input, 0, fn [a, b], total ->
        a * b + total
      end)

    assert result == 184_122_457
  end

  test "Part 2 - input file", %{input: input} do
    assert Day03.part_2(input) == 107_862_689
  end
end
