defmodule Advent2023.Day04 do
  @moduledoc """
  --- Day 4: Scratchcards ---
  https://adventofcode.com/2023/day/4
  """

  @doc """
  Take a seat in the large pile of colorful cards. How many points are they
  worth in total?

  ## Examples

      iex> input = [
      ...>   {[41, 48, 83, 86, 17], [83, 86,  6, 31, 17,  9, 48, 53]},
      ...>   {[13, 32, 20, 16, 61], [61, 30, 68, 82, 17, 32, 24, 19]},
      ...>   {[ 1, 21, 53, 59, 44], [69, 82, 63, 72, 16, 21, 14,  1]},
      ...>   {[41, 92, 73, 84, 69], [59, 84, 76, 51, 58,  5, 54, 83]},
      ...>   {[87, 83, 26, 28, 32], [88, 30, 70, 12, 93, 22, 82, 36]},
      ...>   {[31, 18, 13, 56, 72], [74, 77, 10, 23, 35, 67, 36, 11]}
      ...> ]
      iex> part_1(input)
      13

  """
  def part_1(input) do
    Enum.reduce(input, 0, fn {winning_numbers, numbers}, total ->
      total + score(length(winning_numbers) - length(winning_numbers -- numbers))
    end)
  end

  defp score(0), do: 0
  defp score(n), do: 2 ** (n - 1)

  @doc """
  Including the original set of scratchcards, how many total scratchcards do you end up with?

  ## Examples

      iex> input = [
      ...>   {[41, 48, 83, 86, 17], [83, 86,  6, 31, 17,  9, 48, 53]},
      ...>   {[13, 32, 20, 16, 61], [61, 30, 68, 82, 17, 32, 24, 19]},
      ...>   {[ 1, 21, 53, 59, 44], [69, 82, 63, 72, 16, 21, 14,  1]},
      ...>   {[41, 92, 73, 84, 69], [59, 84, 76, 51, 58,  5, 54, 83]},
      ...>   {[87, 83, 26, 28, 32], [88, 30, 70, 12, 93, 22, 82, 36]},
      ...>   {[31, 18, 13, 56, 72], [74, 77, 10, 23, 35, 67, 36, 11]}
      ...> ]
      iex> part_2(input)
      30

  """
  def part_2(input) do
    input
    |> Enum.reduce({1, %{}, 0}, &calculate_game/2)
    |> elem(2)
  end

  defp calculate_game({winning_numbers, numbers}, {i, copies, total}) do
    wins = length(winning_numbers) - length(winning_numbers -- numbers)
    copy_count = Map.get(copies, i, 0) + 1
    
    copies =
      if wins > 0 do
        Enum.reduce((i + 1)..(i + wins), copies, fn j, acc ->
          Map.update(acc, j, copy_count, &(&1 + copy_count))
        end)
      else
        copies
      end

    {i + 1, copies, wins * copy_count + total + 1}
  end
end
