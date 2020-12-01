defmodule Advent.Day1 do
  @moduledoc """
  --- Day 1: Report Repair ---

  https://adventofcode.com/2020/day/1
  """

  @type filename :: String.t()

  @type entries :: [integer()]

  @doc """
  ## Part One

  Find the two entries that sum to 2020 and then multiply those two numbers
  together.

  Accepts a filename of items or the list of entries.
  """
  @spec part_1(filename | entries) :: integer()
  def part_1(filename) when is_binary(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> part_1()
  end

  def part_1(entries) when is_list(entries) do
    entries
    |> Enum.with_index()
    |> get_results()
    |> List.first()
  end

  # Brute force method, don't judge me.
  defp get_results(items) do
    for {x, i} <- items, {y, j} <- items, i != j and x + y == 2020 do
      x * y
    end
  end
end
