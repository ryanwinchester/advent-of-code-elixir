defmodule Advent2023.Day04Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2023

  doctest Advent2023.Day04Parser, import: true
  doctest Advent2023.Day04, import: true

  setup do
    input = parse_input({2023, 4}, Advent2023.Day04Parser)
    answers = load_answers({2023, 4})
    {:ok, input: input, answers: answers}
  end

  test "Part 1 - input file", %{input: input, answers: answers} do
    assert Advent2023.Day04.part_1(input) == answers[1]
  end

  test "Part 2 - input file", %{input: input, answers: answers} do
    assert Advent2023.Day04.part_2(input) == answers[2]
  end
end
