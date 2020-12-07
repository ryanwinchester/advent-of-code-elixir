defmodule Advent.Day06 do
  @moduledoc """
  --- Day 6: Custom Customs ---
  https://adventofcode.com/2020/day/6
  """

  @doc """
  Gets the sum of any group "yes" answers.

  ## Example

      iex> Day06.part_1(input)
      11

  """
  def part_1(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(&count_group_any_yes/1)
    |> Enum.sum()
  end

  @doc """
  Gets the sum of all group "yes" answers.

  ## Example

      iex> Day06.part_1(input)
      6

  """
  def part_2(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(&count_group_all_yes/1)
    |> Enum.sum()
  end

  defp count_group_any_yes(group_answers) do
    Enum.reduce(?a..?z, 0, fn question, total ->
      if Enum.any?(group_answers, &String.contains?(&1, <<question>>)) do
        total + 1
      else
        total
      end
    end)
  end

  defp count_group_all_yes(group_answers) do
    Enum.reduce(?a..?z, 0, fn question, total ->
      if Enum.all?(group_answers, &String.contains?(&1, <<question>>)) do
        total + 1
      else
        total
      end
    end)
  end
end
