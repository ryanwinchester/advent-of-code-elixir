defmodule Advent2024.Day01 do
  @moduledoc """
  --- Day 1: Historian Hysteria ---

  https://adventofcode.com/2024/day/1
  """

  @doc """
  What is the total distance between the lists?

  ## Example

      iex> left_list = [3, 4, 2, 1, 3, 3]
      iex> right_list = [4, 3, 5, 3, 9, 3]
      iex> Day01.part_1(left_list, right_list)
      11

  """
  def part_1(left_list, right_list) do
    [Enum.sort(left_list), Enum.sort(right_list)]
    |> Enum.zip()
    |> Enum.reduce(0, fn {a, b}, acc -> abs(a - b) + acc end)
  end

  @doc """
  What is their similarity score?

  ## Example

      iex> left_list = [3, 4, 2, 1, 3, 3]
      iex> right_list = [4, 3, 5, 3, 9, 3]
      iex> Day01.part_2(left_list, right_list)
      31

  """
  def part_2(left_list, right_list) do
    frequencies = Enum.frequencies(right_list)

    Enum.reduce(left_list, 0, fn n, similarity ->
      freq = Map.get(frequencies, n, 0)
      n * freq + similarity
    end)
  end
end
