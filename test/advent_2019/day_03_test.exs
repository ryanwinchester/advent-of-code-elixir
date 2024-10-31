defmodule Advent2019.Day03Test do
  use Advent.FileCase, async: true

  @moduletag :advent_2019

  alias Advent2019.Day03

  doctest Day03

  test "Part 1 - input file" do
    [path_1, path_2] = load_input_lines({2019, 3}) |> Enum.map(&String.split(&1, ","))
    assert Day03.part_1(path_1, path_2) == 266
  end

  test "Part 2 - input file" do
    [path_1, path_2] = load_input_lines({2019, 3}) |> Enum.map(&String.split(&1, ","))
    assert Day03.part_2(path_1, path_2) == 19242
  end
end
