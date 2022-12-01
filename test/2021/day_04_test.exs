defmodule Advent2021.Day04Test do
  use Advent.FileCase

  alias Advent2021.Day04

  doctest Day04

  setup do
    [numstring | boardstrings] = load_file_chunks(2021, "day-04")

    numbers =
      numstring
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    boards =
      boardstrings
      |> Enum.map(fn boardstring ->
        boardstring
        |> String.split("\n", trim: true)
        |> Enum.map(fn rowstring ->
          rowstring
          |> String.split(" ", trim: true)
          |> Enum.map(&String.to_integer/1)
        end)
      end)

    {:ok, numbers: numbers, boards: boards}
  end

  test "Part 1 - input file", %{numbers: numbers, boards: boards} do
    assert Day04.part_1(numbers, boards) == 51034
  end

  test "Part 2 - input file", %{numbers: numbers, boards: boards} do
    assert Day04.part_2(numbers, boards) == 5434
  end
end
