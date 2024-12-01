defmodule Advent2024.Day01 do
  @moduledoc """
  --- Day 1: Historian Hysteria ---

  https://adventofcode.com/2024/day/1
  """

  @doc """
  What is the total distance between the lists?

  ## Example

      iex> list_1 = [3, 4, 2, 1, 3, 3]
      iex> list_2 = [4, 3, 5, 3, 9, 3]
      iex> Day01.part_1(list_1, list_2)
      11

  """
  def part_1(list_1, list_2) do
    [Enum.sort(list_1), Enum.sort(list_2)]
    |> Enum.zip()
    |> Enum.reduce(0, fn {a, b}, acc -> abs(a - b) + acc end)
  end

  @doc """
  What is their similarity score?

  ## Example

      iex> list_1 = [3, 4, 2, 1, 3, 3]
      iex> list_2 = [4, 3, 5, 3, 9, 3]
      iex> Day01.part_2(list_1, list_2)
      31

  """
  def part_2(list_1, list_2) do
    frequencies = Enum.frequencies(list_2)

    Enum.reduce(list_1, 0, fn n, similarity ->
      freq = Map.get(frequencies, n, 0)
      n * freq + similarity
    end)
  end
end
