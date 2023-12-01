defmodule Advent2023.Day01Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2023

  doctest Advent2023.Day01, import: true

  setup do
    input = load_input_lines({2023, 1})
    answers = load_answers({2023, 1})
    {:ok, input: input, answers: answers}
  end

  test "Part 1 - input file", %{input: input, answers: answers} do
    assert Advent2023.Day01.part_1(input) == answers[1]
  end

  test "Part 2 - input file", %{input: input, answers: answers} do
    assert Advent2023.Day01.part_2(input) == answers[2]
  end
end
