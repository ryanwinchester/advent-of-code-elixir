defmodule Advent2019.Day04Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2019

  alias Advent2019.Day04

  doctest Day04

  test "Part 1 - input" do
    assert Day04.part_1(367_479..893_698) == 495
  end

  # test "Part 2 - input file" do
  #   [path_1, path_2] = load_input_lines({2019, 3}) |> Enum.map(&String.split(&1, ","))
  #   assert Day04.part_2(path_1, path_2) == 266
  # end
end
